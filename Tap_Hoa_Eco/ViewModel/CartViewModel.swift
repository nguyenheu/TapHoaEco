//
//  CartViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 18/04/2024.
//

import Foundation

class CartViewModel: ObservableObject {
    static var shared: CartViewModel = CartViewModel()
    
    @Published var showError = false
    @Published var showOrderAccept = false
    @Published var errorMessage = ""
    
    @Published var listArr: [CartItemModel] = []
    @Published var total: String = ""
    
    @Published var showCheckout: Bool = false
    
    @Published var showPickerAddress: Bool = false
    @Published var showPickerPayment: Bool = false
    @Published var showPickerPromoCode: Bool = false
    
    @Published var deliveryType: Int = 1
    @Published var paymentType: Int = 1
    @Published var deliverObj: AddressModel?
    @Published var paymentObj: PaymentModel?
    @Published var promoObj: PromoCodeModel?
    
    @Published var deliverPriceAmount: String = ""
    @Published var discountAmount: String = ""
    @Published var userPayAmount: String = ""
    
    
    init() {
        serviceCallList()
    }
    
    //MARK: ServiceCall
    func serviceCallList(){
        ServiceCall.post(parameter: ["promo_code_id": promoObj?.id ?? "", "delivery_type": deliveryType ], path: Globs.SV_CART_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.total = response.value(forKey: "total") as? String ?? "0"
                    self.discountAmount = response.value(forKey: "discount_amount") as? String ?? "0"
                    self.deliverPriceAmount = response.value(forKey: "deliver_price_amount") as? String ?? "0"
                    self.userPayAmount = response.value(forKey: "user_pay_price") as? String ?? "0"
                    
                   
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return CartItemModel(dict: obj as? NSDictionary ?? [:])
                    })
                
                }else{
                    self.total = response.value(forKey: "total") as? String ?? "0"
                    self.discountAmount = response.value(forKey: "discount_amount") as? String ?? "0"
                    self.deliverPriceAmount = response.value(forKey: "deliver_price_amount") as? String ?? "0"
                    self.userPayAmount = response.value(forKey: "user_pay_price") as? String ?? "0"
                    
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallUpdateQty(cObj: CartItemModel, newQty: Int ){
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.prodId, "new_qty": newQty ], path: Globs.SV_UPDATE_CART, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    self.serviceCallList()
                
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallRemove(cObj: CartItemModel){
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.prodId ], path: Globs.SV_REMOVE_CART, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.serviceCallList()
                
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    func serviceCallOrderPlace() {
        if(deliveryType == 1 && deliverObj == nil ) {
            self.errorMessage = "Vui lòng chọn địa chỉ giao hàng"
            self.showError = true
            return
        }

        if(paymentType == 2 && paymentObj == nil ) {
            self.errorMessage = "Vui lòng chọn phương thức thanh toán"
            self.showError = true
            return
        }

        ServiceCall.post(parameter: ["address_id": deliveryType == 2 ? "" : "\( deliverObj?.id ?? 0)",
                                     "deliver_type": deliveryType,
                                     "payment_type": paymentType,
                                     "pay_id": paymentType == 1 ? "" : "\( paymentObj?.id ?? 0)",
                                     "promo_code_id": promoObj?.id ?? ""  ], path: Globs.SV_ORDER_PLACE, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.deliverObj = nil
                    self.paymentObj = nil
                    self.promoObj = nil
                    self.showCheckout = false
                    self.serviceCallList()

                    self.showOrderAccept = true
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    class func serviceCallAddToCart(prodId: Int, qty: Int, didDone: ((_ isDone: Bool,_ message: String  )->())? ) {
        // First get current cart to check for existing items
        ServiceCall.post(parameter: [:], path: Globs.SV_CART_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let cartItems = (response.value(forKey: KKey.payload) as? NSArray ?? []).map { obj in
                        return CartItemModel(dict: obj as? NSDictionary ?? [:])
                    }
                    
                    // Check if product already exists in cart
                    if let existingItem = cartItems.first(where: { $0.prodId == prodId }) {
                        // Update quantity instead of adding new item
                        ServiceCall.post(
                            parameter: ["cart_id": existingItem.cartId,
                                      "prod_id": prodId,
                                      "new_qty": existingItem.qty + qty],
                            path: Globs.SV_UPDATE_CART,
                            isToken: true
                        ) { responseObj in
                            if let response = responseObj as? NSDictionary {
                                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                                    didDone?(true, "Đã cập nhật số lượng sản phẩm")
                                } else {
                                    didDone?(false, response.value(forKey: KKey.message) as? String ?? "Fail")
                                }
                            }
                        } failure: { error in
                            didDone?(false, error?.localizedDescription ?? "Fail")
                        }
                    } else {
                        // Add new item if it doesn't exist
                        ServiceCall.post(
                            parameter: ["prod_id": prodId, "qty": qty],
                            path: Globs.SV_ADD_CART,
                            isToken: true
                        ) { responseObj in
                            if let response = responseObj as? NSDictionary {
                                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                                    didDone?(true, response.value(forKey: KKey.message) as? String ?? "Done")
                                } else {
                                    didDone?(false, response.value(forKey: KKey.message) as? String ?? "Fail")
                                }
                            }
                        } failure: { error in
                            didDone?(false, error?.localizedDescription ?? "Fail")
                        }
                    }
                }
            }
        } failure: { error in
            didDone?(false, error?.localizedDescription ?? "Fail")
        }
    }
    class func serviceCallAddAllToCart(products: [ProductModel], completion: @escaping (Bool, String) -> Void) {
        let group = DispatchGroup()
        var successCount = 0
        var failureMessage = ""
        
        for product in products {
            group.enter()
            serviceCallAddToCart(prodId: product.prodId, qty: 1) { isDone, message in
                if isDone {
                    successCount += 1
                } else {
                    failureMessage = message
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if successCount == products.count {
                completion(true, "Đã thêm tất cả sản phẩm vào giỏ hàng")
            } else {
                completion(false, failureMessage.isEmpty ? "Không thể thêm một số sản phẩm" : failureMessage)
            }
        }
    }
}

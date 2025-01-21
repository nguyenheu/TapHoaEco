//
//  MyOrderDetailViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 05/05/2024.
//

import SwiftUI

class MyOrderDetailViewModel: ObservableObject {
    @Published var pObj: MyOrderModel = MyOrderModel(dict: [:])
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var listArr: [OrderItemModel] = []
    
    @Published var txtMessage = ""
    @Published var rating: Int = 0
    @Published var showWriteReview = false
    @Published var productObj: OrderItemModel?
    
    
    init(prodObj: MyOrderModel) {
        self.pObj = prodObj
        serviceCallDetail()
    }
    
    //MARK: Action
    func actionWriteReviewOpen(obj: OrderItemModel) {
        // Reset previous review data
        self.rating = 5
        self.txtMessage = ""
        self.productObj = nil // Clear previous product first
        
        // Set new product object
        self.productObj = obj
        
        // Show review screen
        self.showWriteReview = true
    }
    
    //MARK: ServiceCall
    
    func serviceCallDetail(){
        ServiceCall.post(parameter: ["order_id": self.pObj.id ], path: Globs.SV_MY_ORDERS_DETAIL, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    if let payloadObj = response.value(forKey: KKey.payload) as? NSDictionary {
                        
                        self.pObj = MyOrderModel(dict: payloadObj)
                        self.listArr = (payloadObj.value(forKey: "cart_list") as? NSArray ?? []).map({ obj in
                            return OrderItemModel(dict: obj as? NSDictionary ?? [:])
                        })
                    }
                    
                    
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
    
    func serviceCallWriteReview(didDone: (()->())?) {
        ServiceCall.post(parameter: [
            "order_id": self.pObj.id,
            "prod_id": self.productObj?.prodId ?? "",
            "rating": rating,
            "review_message": txtMessage
        ], path: Globs.SV_PRODUCT_RATING_REVIEW, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.showWriteReview = false
                    didDone?()
                    
                    self.serviceCallDetail()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                        self.showError = true
                    }
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
}

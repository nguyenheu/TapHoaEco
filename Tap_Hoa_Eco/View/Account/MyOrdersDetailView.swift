//
//  MyOrdersDetailView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct MyOrdersDetailView: View {
    @StateObject var detailVM: MyOrderDetailViewModel = MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [:]) )
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack{
                    HStack{
                        Text("\(DataConstants.Order.orderID.localized): # \( detailVM.pObj.id )")
                            .font(.nunito(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Text(OrderHelper.getPaymentStatus(mObj: detailVM.pObj )  )
                            .font(.nunito(.bold, fontSize: 18))
                            .foregroundColor(OrderHelper.getPaymentStatusColor(mObj: detailVM.pObj))
                    }
                    
                    HStack{
                        Text(detailVM.pObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                            .font(.nunito(.regular, fontSize: 12))
                            .foregroundColor(.secondaryText)
                        
                        Spacer()
                        
                        Text(OrderHelper.getOrderStatus(mObj: detailVM.pObj ))
                            .font(.nunito(.bold, fontSize: 18))
                            .foregroundColor(OrderHelper.getOrderStatusColor(mObj: detailVM.pObj))
                    }
                    .padding(.bottom, 8)
                    
                    HStack{
                        Text("\(DataConstants.Order.deliveryType.localized):")
                            .font(.nunito(.bold, fontSize: 16))
                        
                        Spacer()
                        
                        Text(OrderHelper.getDeliveryType(mObj: detailVM.pObj ))
                            .font(.nunito(.regular, fontSize: 16))
                    }
                    .foregroundColor(.primaryText)
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("\(DataConstants.Order.paymentType.localized):")
                            .font(.nunito(.bold, fontSize: 16))
                        
                        Spacer()
                        
                        Text(OrderHelper.getPaymentType(mObj: detailVM.pObj ))
                            .font(.nunito(.regular, fontSize: 16))
                    }
                    .foregroundColor(.primaryText)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal)
                
                LazyVStack {
                    ForEach(detailVM.listArr, id: \.id) { pObj in
                        OrderItemRow(pObj: pObj, showReviewBotton: detailVM.pObj.orderStatus == 3) {
                            detailVM.actionWriteReviewOpen(obj: pObj)
                        }
                    }
                }
                
                VStack(spacing: 4){
                    HStack{
                        Text("\(DataConstants.Order.payment.localized):")
                        
                        Spacer()
                        
                        Text("\( detailVM.pObj.totalPrice, specifier: "%.0f")K")
                    }
                    
                    HStack{
                        Text("\(DataConstants.Order.shipping.localized):")
                        
                        Spacer()
                        
                        Text("+ \(detailVM.pObj.deliverPrice ?? 0.0, specifier: "%.0f")K")
                    }

                    HStack{
                        Text("\(DataConstants.Order.discount.localized):")
                        
                        Spacer()
                        
                        Text("- \(detailVM.pObj.discountPrice ?? 0.0, specifier: "%.0f")K")
                            .foregroundColor(.red)
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("\(DataConstants.Order.total.localized):")
                            .font(.nunito(.bold, fontSize: 22))
                        
                        Spacer()
                        
                        Text( "\( detailVM.pObj.userPayPrice ?? 0.0, specifier: "%.0f")K")
                            .font(.nunito(.bold, fontSize: 22))
                            
                    }
                }
                .foregroundColor(.primaryText)
                .font(.nunito(.bold, fontSize: 18))
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal)
                
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.Order.orderDetails.localized)
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $detailVM.showError, content: {
                Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage), dismissButton: .default(Text(DataConstants.Order.ok.localized)))
            })
        }
        .navigationDestination(isPresented: $detailVM.showWriteReview) {
            WriteReviewView(vm: detailVM)
        }
    }
}

#Preview {
    MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [
        "order_id": 1,
        "cart_id": "2",
        "total_price": 19.9,
        "user_pay_price": 19.91,
        "discount_price": 1.99,
        "deliver_price": 2,
        "deliver_type": 1,
        "payment_type": 1,
        "payment_status": 1,
        "order_status": 3,
        "status": 1,
        "created_date": "2024-04-30 11:03:14",
        "names": "Súp Lơ",
        "images": "http://localhost:3001/img/product/20240428081305135YSvnI0SYJp.png",
        "user_name": "Mat",
        "phone": "0123456789",
        "address": "15 Gốc Đề",
        "city": "Hà Nội",
    ])))
}

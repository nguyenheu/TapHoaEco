//
//  MyOrdersView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct MyOrdersView: View {    
    @StateObject var myVM = MyOrdersViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach( myVM.listArr, id: \.id) {myObj in
                        NavigationLink {
                            MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: myObj) )
                        } label: {
                            VStack{
                                HStack {
                                    Text("\(DataConstants.Order.orderTitle.localized): #")
                                        .font(.nunito(.bold, fontSize: 16))
                                        .foregroundColor(.primaryText)
                                    
                                    Text("\(myObj.id)")
                                        .font(.nunito(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(OrderHelper.getOrderStatus(mObj: myObj))
                                        .font(.nunito(.bold, fontSize: 16))
                                        .foregroundColor(OrderHelper.getOrderStatusColor(mObj: myObj) )
                                }
                                
                                Text(myObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.nunito(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    VStack{
                                        HStack {
                                            Text("\(DataConstants.Order.items.localized):")
                                                .font(.nunito(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            Text(myObj.names)
                                                .font(.nunito(.bold, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("\(DataConstants.Order.deliveryType.localized):")
                                                .font(.nunito(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            Text(OrderHelper.getDeliveryType(mObj: myObj) )
                                                .font(.nunito(.bold, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("\(DataConstants.Order.paymentType.localized):")
                                                .font(.nunito(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            
                                            Text(OrderHelper.getPaymentType(mObj: myObj))
                                                .font(.nunito(.bold, fontSize: 14))
                                                .foregroundColor(.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("\(DataConstants.Order.status.localized):")
                                                .font(.nunito(.bold, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            Text(OrderHelper.getPaymentStatus(mObj: myObj))
                                                .font(.nunito(.bold, fontSize: 14))
                                                .foregroundColor(OrderHelper.getPaymentStatusColor(mObj: myObj))
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                    }
                    
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.Order.title.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: myVM.serviceCallList)
    }
}
#Preview {
    MyOrdersView()
}

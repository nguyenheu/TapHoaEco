//
//  CartView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct CartView: View {
    @StateObject var cartVM = CartViewModel.shared
    @StateObject var myOrdersVM = MyOrdersViewModel.shared
    @State private var navigateToMyOrders = false
    
    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack {
                if(cartVM.listArr.count <= 0) {
                    VStack(alignment: .center, spacing: 20) {
                        Image(systemName: "cart.badge.questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text(DataConstants.Cart.emptyCart.localized)
                            .font(.nunito(.bold, fontSize: 20))
                    }
                    .foregroundStyle(Color.black)
                    
                } else {
                    ScrollView{
                        LazyVStack {
                            ForEach(cartVM.listArr, id: \.id) { cObj in
                                CartItemRow(cObj: cObj)
                            }
                            .padding(.vertical, 8)
                        }
                        .padding()
                    }
                    
                    RoundButton(title: DataConstants.Cart.checkout.localized) {
                        cartVM.showCheckout = true
                    }
                    .overlay(alignment: .trailing) {
                        Text("\(cartVM.total)K")
                            .font(.nunito(.bold, fontSize: 12))
                            .foregroundStyle(Color.white)
                            .padding(8)
                            .background(Color.darkGray.opacity(0.2))
                            .cornerRadius(6)
                            .padding(.trailing, 32)
                    }
                    .padding(.bottom, 60)
                }
            }
            .navigationTitle(DataConstants.Cart.title.localized)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: cartVM.serviceCallList)
            .navigationDestination(isPresented: $cartVM.showCheckout) {
                CheckoutView()
            }
            .sheet(isPresented: $cartVM.showOrderAccept) {
                OrderAcceptView(didTapTrackOrder: {
                    navigateToMyOrders = true
                })
            }
            .navigationDestination(isPresented: $navigateToMyOrders) {
                MyOrdersView()
            }
            .alert(isPresented: $cartVM.showError) {
                Alert(title: Text(Globs.AppName), message: Text(cartVM.errorMessage), dismissButton: .default(Text(DataConstants.Cart.ok.localized)))
            }
        }
    }
}

#Preview {
    CartView()
}

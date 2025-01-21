//
//  CheckoutView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct CheckoutView: View {
    @StateObject var cartVM = CartViewModel.shared
    @Environment(\.dismiss) private var dismiss
  
    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack{
                CheckoutOptionsView(cartVM: cartVM)

                orderSummarySection

                Spacer()
                
                RoundButton(title: DataConstants.Checkout.placeOrder.localized) {
                    cartVM.serviceCallOrderPlace()
                }
            }
            .navigationTitle(DataConstants.Checkout.title.localized)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
        }
    }
}

extension CheckoutView {
    private var orderSummarySection: some View {
        VStack{
            HStack {
                Text(DataConstants.Checkout.subTotal.localized)
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                
                Spacer()
                
                Text("\(cartVM.total)K")
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.secondaryText)
            }
            
            HStack {
                Text(DataConstants.Checkout.deliveryFee.localized)
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                
                Spacer()
                
                Text("+ \(cartVM.deliverPriceAmount)K")
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.secondaryText)
            }
            
            HStack {
                Text(DataConstants.Checkout.discount.localized)
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                
                Spacer()
                
                Text("- \(cartVM.discountAmount)K")
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.red)
            }
            
            HStack {
                Text(DataConstants.Checkout.total.localized)
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Text("\(cartVM.userPayAmount)K")
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(height: 46)
            }
        }
        .padding(.horizontal)
    }
}

struct CheckoutOptionsView: View {
    @ObservedObject var cartVM: CartViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(DataConstants.Checkout.deliveryType.localized)
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Picker("", selection: $cartVM.deliveryType) {
                    Text(DataConstants.Checkout.delivery.localized).tag(1)
                    Text(DataConstants.Checkout.pickup.localized).tag(2)
                }
                .pickerStyle(.segmented)
                .background(Color.primaryApp)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 180)
            }
            
            Divider()
            
            if cartVM.deliveryType == 1 {
                DeliveryPickerRow(cartVM: cartVM)
            }
            
            PaymentTypeRow(cartVM: cartVM)
            
            if cartVM.paymentType == 2 {
                PaymentMethodRow(cartVM: cartVM)
            }
            
            PromoCodeRow(cartVM: cartVM)
        }
    }
}

// Add this new view for delivery selection
struct DeliveryPickerRow: View {
    @ObservedObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationLink {
            DeliveryAddressView(isPicker: true, didSelect: { aObj in
                cartVM.deliverObj = aObj
            })
        } label: {
            HStack {
                Text(DataConstants.Checkout.deliveryTitle.localized)
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Text(cartVM.deliverObj?.name ?? DataConstants.Checkout.choose.localized)
                    .foregroundStyle(Color.primaryText)
                    .font(.nunito(.regular, fontSize: 16))
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.primaryText)
            }
        }
        Divider()
    }
}

struct PaymentTypeRow: View {
    @ObservedObject var cartVM: CartViewModel
    
    var body: some View {
        HStack {
            Text(DataConstants.Checkout.paymentType.localized)
                .font(.nunito(.bold, fontSize: 18))
                .foregroundColor(.secondaryText)
                .frame(height: 46)
            
            Spacer()
            
            Picker("", selection: $cartVM.paymentType) {
                Text("COD").tag(1)
                Text("Online").tag(2)
            }
            .pickerStyle(.segmented)
            .background(Color.primaryApp)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: 150)
        }
        Divider()
    }
}

struct PaymentMethodRow: View {
    @ObservedObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationLink {
            PaymentMethodsView(isPicker: true, didSelect: { pObj in
                cartVM.paymentObj = pObj
            })
        } label: {
            HStack {
                Text(DataConstants.Checkout.paymentTitle.localized)
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Text(cartVM.paymentObj?.cardNumber ?? DataConstants.Checkout.choose.localized)
                    .foregroundStyle(Color.primaryText)
                    .font(.nunito(.regular, fontSize: 16))
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.primaryText)
            }
        }
        Divider()
    }
}

struct PromoCodeRow: View {
    @ObservedObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationLink {
            PromoCodeView(isPicker: true, didSelect: { pObj in
                cartVM.promoObj = pObj
            })
        } label: {
            HStack {
                Text(DataConstants.Checkout.promoCode.localized)
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Text(cartVM.promoObj?.code ?? DataConstants.Checkout.choose.localized)
                    .font(.nunito(.regular, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(height: 46)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.primaryText)
            }
        }
    }
}

#Preview {
    CheckoutView()
}

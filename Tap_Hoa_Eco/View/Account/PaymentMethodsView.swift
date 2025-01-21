//
//  PaymentMethodsView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct PaymentMethodsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var payVM = PaymentViewModel.shared
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: PaymentModel) -> () )?
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(payVM.listArr , id: \.id) { pObj in
                        ZStack {
                            LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .clipShape(.rect(cornerRadius: 25))
                        }
                        .frame(height: 200)
                        .overlay {
                            CardFrontView(pObj: pObj)
                        }
//                        .overlay(alignment: .topTrailing) {
//                            Button {
//                                payVM.serviceCallRemove(pObj: pObj)
//                            } label: {
//                                Image(systemName: "multiply.circle.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundColor(Color.primaryApp)
//                                    .frame(width: 20, height: 20)
//                            }
//                        }
                        .onTapGesture {
                            if(isPicker) {
                                dismiss()
                                didSelect?(pObj)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.Payment.title.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddPaymentMethodView()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.primaryApp)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .alert(isPresented: $payVM.showError, content: {
            Alert(title: Text(Globs.AppName),
                  message: Text(payVM.errorMessage),
                  dismissButton: .default(Text(DataConstants.Payment.ok.localized)))
        })
    }
    
    @ViewBuilder
    private func CardFrontView(pObj: PaymentModel) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
                Text(DataConstants.Payment.cardNumber.localized)
                
                Text(formattedCardNumber(number: pObj.cardNumber))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(10)
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(DataConstants.Payment.cardholderName.localized)
                        .font(.caption)
                    
                    Text(pObj.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(DataConstants.Payment.expires.localized)
                        .font(.caption)
                    
                    HStack(spacing: 4) {
                        Text(pObj.cardMonth)
                        Text("/")
                        Text(pObj.cardYear)
                    }
                }
                .frame(maxWidth: 96, alignment: .trailing)
                .padding(10)
            }
        }
        .foregroundStyle(.white)
        .monospaced()
        .contentTransition(.numericText())
        .padding(15)
    }
    
    private func formattedCardNumber(number: String) -> String {
        let last4 = String(number.suffix(4))
        return "**** **** **** " + last4
    }
}
#Preview {
    PaymentMethodsView()
}

//
//  OrderAcceptView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct OrderAcceptView: View {
    @Environment(\.dismiss) private var dismiss
    var didTapTrackOrder: (() -> Void)?
    
    var body: some View {
        ZStack{
            Color.primaryApp
            
            Image(.bg)
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Image(.success)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.7)
                    .padding(.bottom, 32)
                
                Text(DataConstants.OrderAccept.orderAccepted.localized)
                    .multilineTextAlignment(.center)
                    .font(.nunito(.bold, fontSize: 28))
                    .foregroundColor(.primaryApp)
                    .padding(.bottom, 12)
                
                Text(DataConstants.OrderAccept.orderProcessing.localized)
                    .multilineTextAlignment(.center)
                    .font(.nunito(.regular, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .padding(.bottom, 12)
                
                RoundButton(title: DataConstants.OrderAccept.trackOrder.localized) {
                    dismiss()
                    didTapTrackOrder?()
                }
                
                Button {
                    dismiss()
                } label: {
                    Text(DataConstants.OrderAccept.goBack.localized)
                        .font(.nunito(.bold, fontSize: 18))
                        .foregroundColor(.primaryApp)
                        .frame(width: .screenWidth - 100, height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.primaryApp, lineWidth: 1)
                        }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12, corner: .allCorners)
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OrderAcceptView()
}

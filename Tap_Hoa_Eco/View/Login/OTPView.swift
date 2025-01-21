//
//  OTPView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 19/5/24.
//

import SwiftUI

struct OTPView: View {
    @StateObject var forgotVM = ForgotPasswordViewModel.shared;
    
    var body: some View {
        VStack{
            CustomTextField(
                title: DataConstants.OTP.codeTitle.localized,
                placeholder: DataConstants.OTP.codePlaceholder.localized,
                txt: $forgotVM.txtResetCode,
                keyboardType: .phonePad
            )
            
            HStack {
                Button {
                    forgotVM.serviceCallRequest()
                } label: {
                    Text(DataConstants.OTP.resendButton.localized)
                        .font(.nunito(.bold, fontSize: 18))
                        .foregroundColor(.primaryApp)
                        
                }
                
                Spacer()
                
                Button {
                    forgotVM.serviceCallVerify()
                } label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(15)
                }
                .foregroundColor(.white)
                .background(Color.primaryApp)
                .clipShape(Circle())
            }

            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(DataConstants.OTP.title.localized)
        .alert(isPresented: $forgotVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text( forgotVM.errorMessage ), dismissButton: .default(Text(DataConstants.OTP.okButton.localized)))
        }
        .background(Color.bgColor)
    }
}

#Preview {
    OTPView()
}

//
//  ForgotPassword.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct ForgotPassword: View {
    @StateObject var forgotVM = ForgotPasswordViewModel.shared;
    
    var body: some View {
        VStack{
            CustomTextField(
                title: DataConstants.ForgotPassword.emailTitle.localized,
                placeholder: DataConstants.ForgotPassword.emailPlaceholder.localized,
                txt: $forgotVM.txtEmail,
                keyboardType: .emailAddress
            )

            RoundButton(title: DataConstants.ForgotPassword.submitButton.localized) {
                forgotVM.serviceCallRequest()
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(DataConstants.ForgotPassword.title.localized)
        .alert(isPresented: $forgotVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text( forgotVM.errorMessage ), dismissButton: .default(Text(DataConstants.ForgotPassword.okButton.localized)))
        }
        .sheet(isPresented: $forgotVM.showVerify, content: {
            OTPView()
        })
        .sheet(isPresented: $forgotVM.showSetPassword, content: {
            SetPassword()
        })
        .background(Color.bgColor)
    }
}

#Preview {
    ForgotPassword()
}

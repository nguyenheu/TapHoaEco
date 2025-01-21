//
//  SetPassword.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 19/5/24.
//

import SwiftUI

struct SetPassword: View {
    @StateObject var forgotVM = ForgotPasswordViewModel.shared;
    
    var body: some View {
        VStack(spacing: 24){
            CustomSecureField(
                title: DataConstants.SetPassword.newPasswordTitle.localized,
                placeholder: DataConstants.SetPassword.newPasswordPlaceholder.localized,
                txt: $forgotVM.txtNewPassword,
                isShowPassword: $forgotVM.isNewPassword
            )
            
            CustomSecureField(
                title: DataConstants.SetPassword.confirmPasswordTitle.localized,
                placeholder: DataConstants.SetPassword.confirmPasswordPlaceholder.localized,
                txt: $forgotVM.txtConfirmPassword,
                isShowPassword: $forgotVM.isConfirmPassword
            )
            
            RoundButton(title: DataConstants.SetPassword.changePasswordButton.localized) {
                forgotVM.serviceCallSetPassword()
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(DataConstants.SetPassword.title.localized)
        .alert(isPresented: $forgotVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text( forgotVM.errorMessage ), dismissButton: .default(Text(DataConstants.SetPassword.okButton.localized)))
        }
        .background(Color.bgColor)
    }
}

#Preview {
    SetPassword()
}

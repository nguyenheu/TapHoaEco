//
//  ChangePasswordView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct ChangePasswordView: View {
    @StateObject var myVM = MyDetailsViewModel.shared

    var body: some View {
        ZStack {
            ScrollView{
                VStack(spacing: 24){
                    CustomSecureField(
                        title: DataConstants.PasswordChange.currentPassword.localized,
                        placeholder: DataConstants.PasswordChange.currentPasswordPlaceholder.localized,
                        txt: $myVM.txtCurrentPassword,
                        isShowPassword: $myVM.isCurrentPassword
                    )
                    
                    CustomSecureField(
                        title: DataConstants.PasswordChange.newPassword.localized,
                        placeholder: DataConstants.PasswordChange.newPasswordPlaceholder.localized,
                        txt: $myVM.txtNewPassword,
                        isShowPassword: $myVM.isNewPassword
                    )
                    
                    CustomSecureField(
                        title: DataConstants.PasswordChange.confirmPassword.localized,
                        placeholder: DataConstants.PasswordChange.confirmPasswordPlaceholder.localized,
                        txt: $myVM.txtConfirmPassword,
                        isShowPassword: $myVM.isConfirmPassword
                    )
                    
                    RoundButton(title: DataConstants.PasswordChange.update.localized) {
                        myVM.serviceCallChangePassword()
                    }
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.PasswordChange.title.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(isPresented: $myVM.showError) {
            Alert(
                title: Text(Globs.AppName),
                message: Text(myVM.errorMessage),
                dismissButton: .default(Text(DataConstants.PasswordChange.ok.localized))
            )
        }
    }
}

#Preview {
    ChangePasswordView()
}

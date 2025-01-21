//
//  LoginView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = MainViewModel.shared
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryApp.ignoresSafeArea()
                Image(.bg)
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack {
                    Spacer()
                    
                    Text(DataConstants.Login.title.localized)
                        .font(.nunito(.bold, fontSize: 26))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 4)
                    
                    Text(DataConstants.Login.subtitle.localized)
                        .font(.nunito(.regular, fontSize: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    VStack {                        
                        CustomTextField(
                            title: DataConstants.Login.emailTitle.localized,
                            placeholder: DataConstants.Login.emailPlaceholder.localized,
                            txt: $loginVM.txtEmail,
                            keyboardType: .emailAddress,
                            showError: loginVM.showError
                        )
                            .padding(.bottom)
                        
                        CustomSecureField(
                            title: DataConstants.Login.passwordTitle.localized,
                            placeholder: DataConstants.Login.passwordPlaceholder.localized,
                            txt: $loginVM.txtPassword,
                            isShowPassword: $loginVM.isShowPassword,
                            showError: loginVM.showError
                        )
                        
                        // Hiển thị thông báo lỗi nếu có
                        if loginVM.showError {
                            Text(loginVM.errorMessage.localized)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        NavigationLink {
                            ForgotPassword()
                        } label: {
                            Text(DataConstants.Login.forgotPassword.localized)
                                .font(.nunito(.bold, fontSize: 14))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .trailing)
                        }
                        
                        Button(action: loginVM.serviceCallLogin) {
                            Text(DataConstants.Login.loginButton.localized)
                                .font(.nunito(.bold, fontSize: 18))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color.primaryApp)
                                .cornerRadius(12)
                                .padding(.bottom, 4)
                        }
                        
                        HStack {
                            Text(DataConstants.Login.noAccount.localized)
                                .font(.nunito(.regular, fontSize: 14))
                                .foregroundColor(.primaryText)
                            
                            NavigationLink {
                                SignUpView()
                            } label: {
                                Text(DataConstants.Login.signUpButton.localized)
                                    .font(.nunito(.bold, fontSize: 14))
                                    .foregroundColor(.primaryApp)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    LoginView()
}

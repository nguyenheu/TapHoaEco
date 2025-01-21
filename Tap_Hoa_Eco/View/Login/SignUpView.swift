//
//  SignUpView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var signUp = MainViewModel.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.primaryApp.ignoresSafeArea()
            Image(.bg)
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
                            
            VStack {
                Spacer()
                
                Text(DataConstants.SignUp.title.localized)
                    .font(.nunito(.bold, fontSize: 26))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 4)
                
                Text(DataConstants.SignUp.subtitle.localized)
                    .font(.nunito(.regular, fontSize: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                VStack {
                    CustomTextField(title: DataConstants.SignUp.usernameTitle.localized, placeholder: DataConstants.SignUp.usernamePlaceholder.localized, txt: $signUp.txtUsername)
                        .padding(.bottom)
                    
                    CustomTextField(title: DataConstants.SignUp.emailTitle.localized, placeholder: DataConstants.SignUp.emailPlaceholder.localized, txt: $signUp.txtEmail, keyboardType: .emailAddress)
                        .padding(.bottom)
                    
                    CustomSecureField(title: DataConstants.SignUp.passwordTitle.localized, placeholder: DataConstants.SignUp.passwordPlaceholder.localized, txt: $signUp.txtPassword, isShowPassword: $signUp.isShowPassword)
                    
                    Button(action: signUp.serviceCallSignUp) {
                        Text(DataConstants.SignUp.signUpButton.localized)
                            .font(.nunito(.bold, fontSize: 18))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryApp)
                            .cornerRadius(12)
                            .padding(.vertical)
                    }
                    
                    HStack {
                        Text(DataConstants.SignUp.haveAccount.localized)
                            .font(.nunito(.regular, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text(DataConstants.SignUp.loginButton.localized)
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
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color.white)
                }
            }
        }
        .alert(isPresented: $signUp.showError, content: {
            Alert(title: Text(Globs.AppName.localized), message: Text(signUp.errorMessage.localized) , dismissButton: .default(Text("Ok")))
        })
        .onChange(of: signUp.isSignUpSuccessful) { success in
            if success {
                signUp.isSignUpSuccessful = false
                dismiss()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}

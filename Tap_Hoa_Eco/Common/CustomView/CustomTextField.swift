//
//  CustomTextField.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct CustomTextField: View {
    var title: String?
    var placeholder: String
    @Binding var txt: String
    var keyboardType: UIKeyboardType = .default
    var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title ?? "")
                .font(.nunito(.bold, fontSize: 16))
                .foregroundColor(Color.textTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("", text: $txt, prompt: Text(placeholder).foregroundColor(Color.textTitle))
                .foregroundStyle(Color.primaryText)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(showError ? .red : Color.gray.opacity(0.7), lineWidth: 1)
                )
        }
    }
}

struct CustomSecureField: View {
    var title: String
    var placeholder: String
    @Binding var txt: String
    @Binding var isShowPassword: Bool
    var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.nunito(.bold, fontSize: 16))
                .foregroundColor(.textTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if (isShowPassword) {
                TextField(placeholder, text: $txt)
                    .foregroundStyle(Color.primaryText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(showError ? .red : Color.gray.opacity(0.7), lineWidth: 1)
                    )
            } else {
                SecureField(placeholder, text: $txt)
                    .autocapitalization(.none)
                    .foregroundStyle(Color.primaryText)
                    .modifier( ShowButton(isShow: $isShowPassword))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(showError ? .red : Color.gray.opacity(0.7), lineWidth: 1)
                    )
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static  var txt: String = ""
    static var previews: some View {
        CustomTextField(title: "sfdsfsf", placeholder: "sfdfs", txt: $txt)
    }
}

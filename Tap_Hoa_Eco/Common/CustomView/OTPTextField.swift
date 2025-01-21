//
//  OTPTextField.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 19/5/24.
//

import SwiftUI

struct OTPTextField: View {
    @Binding var txtOTP: String
    @State var placeholder: String = "-"
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                let otpCode = txtOTP.map { String($0) }
                ForEach(0..<6, id: \.self) { index in
                    VStack {
                        if( index < otpCode.count) {
                            Text( otpCode[index] )
                        }else{
                            Text(placeholder)
                        }
                        
                        Divider()
                    }
                    .frame(width: 45, height: 50)
                }
                Spacer()
            }
            
            TextField("", text: $txtOTP)
                .keyboardType(.numberPad)
                .foregroundColor(.clear)
                .accentColor(.clear)
            
        }
    }
}


#Preview {
    return OTPTextField(txtOTP: .constant(""))
}

//
//  RoundButton.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct RoundButton: View {
    var title: String
    var didTap: (() -> ())?
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.nunito(.bold, fontSize: 18))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
        .background(Color.primaryApp)
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    RoundButton(title: "Bắt đầu")
}

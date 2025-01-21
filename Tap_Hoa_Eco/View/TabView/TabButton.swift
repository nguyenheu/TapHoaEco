//
//  TabButton.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 21/5/24.
//

import SwiftUI

struct TabButton: View {
    
    let title: String
    let icon: String
    var isSelect: Bool = false
    var didSelect: () -> Void
    
    var body: some View {
        Button (action: didSelect) {
            VStack{
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.nunito(.medium, fontSize: 14))
            }
        }
        .foregroundColor(isSelect ? .primaryApp : .primaryText )
        .frame(maxWidth: .infinity)
    }
}

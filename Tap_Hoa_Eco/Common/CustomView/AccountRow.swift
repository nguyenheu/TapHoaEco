//
//  AccountRow.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct AccountRow: View {
    @State var accountItem: AccountItem
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Image(accountItem.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(accountItem.title)
                    .font(.nunito(.bold, fontSize: 16))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
            }
            .foregroundColor(.primaryText)
            .padding()
            
            Divider()
        }
    }
}

#Preview {
    AccountRow(accountItem: .order)
}

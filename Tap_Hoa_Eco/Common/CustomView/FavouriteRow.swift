//
//  FavouriteRow.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteRow: View {
    @State var fObj: ProductModel = ProductModel(dict: [:])
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                WebImage(url: URL(string: fObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    Text(fObj.name)
                        .font(.nunito(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(fObj.unitValue)\(fObj.unitName), \(DataConstants.ProductDetail.price.localized)")
                        .font(.nunito(.bold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("\(fObj.offerPrice ?? fObj.price, specifier: "%.0f")K")
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(Color.primaryText)
            }
            
            Divider()
        }
    }
}

#Preview {
    FavouriteRow()
}

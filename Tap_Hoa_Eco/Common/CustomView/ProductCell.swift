//
//  ProductCell.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCell: View {
    @State var pObj: ProductModel = ProductModel(dict: [:])
    var didAddCart: ( ()->() )?
    
    var body: some View {
        NavigationLink {
            ProductDetailView(detailVM: ProductDetailViewModel(prodObj: pObj))
        } label: {
            VStack{
                WebImage(url: URL(string: pObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: 150, height: 90)
                    .cornerRadius(8, corner: .allCorners)
                
                Text(pObj.name)
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(pObj.unitValue)\(pObj.unitName), \(DataConstants.ProductDetail.price.localized)")
                    .font(.nunito(.bold, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                if pObj.avgRating > 0 {
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(index <= pObj.avgRating ? Color.orange : Color.gray)
                                .frame(width: 15, height: 15)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                } else {
                    Circle().fill(Color.clear)
                        .frame(height: 15)
                }
                
                Text("\(pObj.offerPrice ?? pObj.price, specifier: "%.0f")K")
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .bottomTrailing) {
                Button {
                    didAddCart?()
                } label: {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white)
                        .frame(width: 16, height: 16)
                }
                .frame(width: 40, height: 36)
                .background(Color.primaryApp)
                .cornerRadius(8, corner: [.topLeft, .bottomLeft])
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    ProductCell()
}

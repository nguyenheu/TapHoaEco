//
//  ExploreCategoryCell.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreCategoryCell: View {
    @State var cObj: ExploreCategoryModel = ExploreCategoryModel(dict: [:])

    var body: some View {
        VStack(spacing: 20){
            WebImage(url: URL(string: cObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(maxWidth: .screenWidth - 20, maxHeight: 120)
                .cornerRadius(12, corner: [.topLeft, .topRight])
            
            Text(cObj.name)
                .font(.nunito(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(12)
        .overlay (
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.darkGray.opacity(0.3), lineWidth: 1)
                .shadow(color: .darkGray.opacity(0.3), radius: 5, x: 0, y: 5)
        )
    }
}

#Preview {
    ExploreCategoryCell(cObj: ExploreCategoryModel(dict: [
        "cat_id": 1,
        "cat_name": "Rau củ",
        "image": "http://localhost:3001/img/product/20240609180916916XJkS4Ihy6Z.jpg",
        "color": "53B175"
    ]))
    .padding()
}

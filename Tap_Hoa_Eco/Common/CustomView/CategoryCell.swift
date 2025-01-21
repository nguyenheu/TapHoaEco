//
//  CategoryCell.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryCell: View {
    @State var eObj: ExploreCategoryModel = ExploreCategoryModel(dict: [:])
    var didAddCart: ( ()->() )?
    var body: some View {
        VStack {
            WebImage(url: URL(string: eObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 64)
                .clipShape(Circle())

            Text(eObj.name)
                .font(.nunito(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
        }
        .padding(12)
        .frame(width: 88)
        .background(Color.white)
        .cornerRadius(40, corner: [.topLeft, .topRight])
        .padding(.trailing, 8)
    }
}

#Preview {
    CategoryCell(eObj: ExploreCategoryModel(dict: [
        "cat_id": 1,
        "cat_name": "Rau củ",
        "image": "http://localhost:3001/img/category/2024051514373337338eQBAkouM5.jpeg",
        "color": "53B175"
    ]))
    .preferredColorScheme(.dark)
    .padding()
}

//
//  CartItemRow.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemRow: View {
    @State var cObj: CartItemModel = CartItemModel(dict: [:])
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                WebImage(url: URL(string: cObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    HStack {
                        Text(cObj.name)
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            CartViewModel.shared.serviceCallRemove(cObj: cObj)
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.primaryApp)
                                .frame(width: 18, height: 18)
                        }

                    }
                   
                    
                    Text("\(cObj.unitValue)\(cObj.unitName), \(DataConstants.ProductDetail.price.localized)")
                        .font(.nunito(.bold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    
                    HStack{
                        Button {
                            CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty - 1)
                        } label: {
                            
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.primaryApp)
                                .frame(width: 14, height: 14)
                                .padding(6)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                        )
                        
                        Text( "\(cObj.qty)" )
                            .font(.nunito(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            
                        
                        Button {
                            CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty + 1)
                        } label: {
                            
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.primaryApp)
                                .frame(width: 12, height: 12)
                                .padding(6)
                        }
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Text("\(cObj.offerPrice ?? cObj.price, specifier: "%.0f")K")
                            .font(.nunito(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                    }
                    
                }
            }
            Divider()
        }
    }
}

#Preview {
    CartItemRow(cObj: CartItemModel(dict: [
        "cart_id": 44,
        "user_id": 1,
        "prod_id": 6,
        "qty": 4,
        "cat_id": 2,
        "name": "Xoài",
        "detail": "Quả xoài có vỏ màu vàng hoặc cam và hình dạng dài hoặc tròn. Chúng giàu vitamin C, vitamin A và kali. Xoài thường được ăn sống, sử dụng trong làm sinh tố, salad hoặc làm thành mứt.",
        "unit_name": "Kg",
        "unit_value": "1",
        "nutrition_weight": "100g",
        "price": 20,
        "created_date": "2024-05-05 10:18:32",
        "modify_date": "2024-05-05 10:18:32",
        "cat_name": "Hoa quả",
        "is_fav": 1,
        "offer_price": 11,
        "start_date": "2024-05-05 00:00:00",
        "end_date": "2024-08-10 00:00:00",
        "is_offer_active": 1,
        "image": "http://localhost:3001/img/product/20240513220042042Y4AyLylGj4.jpg",
        "item_price": 11,
        "total_price": 44
               ]))
    .padding(.horizontal, 20)
}

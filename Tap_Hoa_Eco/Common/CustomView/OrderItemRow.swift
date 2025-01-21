//
//  OrderItemRow.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct OrderItemRow: View {
    @State var pObj: OrderItemModel = OrderItemModel(dict: [:])
    var showReviewBotton = false
    var didTap: ( ()->() )?
    
    var body: some View {
        
        VStack {
            HStack(spacing: 15){
                ZStack {
                    AsyncImage(url: URL(string: pObj.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure(let error):
                            Text("Failed to load image: \(error.localizedDescription)")
                        @unknown default:
                            Text("Unknown state")
                        }
                    }
                    .cornerRadius(8)
                }
                .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    Text(pObj.name)
                        .font(.nunito(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(pObj.unitValue)\(pObj.unitName), \(DataConstants.ProductDetail.price.localized)")
                        .font(.nunito(.bold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("Số lượng:")
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("\( pObj.qty )")
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("×")
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("\( pObj.itemPrice, specifier: "%.0f")K")
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("\(pObj.offerPrice ?? pObj.price, specifier: "%.0f")K")
                    .font(.nunito(.bold, fontSize: 18))
                    .foregroundColor(.primaryText)
            }
            
            if showReviewBotton {
                RoundButton(title: "Write a review" ) {
                    didTap?()
                }
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color.black.opacity(0.15), radius: 2)
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}

#Preview {
    OrderItemRow()
}

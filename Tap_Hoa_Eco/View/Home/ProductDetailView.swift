//
//  ProductDetailView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var detailVM: ProductDetailViewModel = ProductDetailViewModel(prodObj: ProductModel(dict: [:]))
    
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            VStack {
                WebImage(url: URL(string: detailVM.pObj.image ))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: .screenWidth)
                    .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                
                ScrollView {
                    VStack {
                        HStack {
                            Text(detailVM.pObj.name)
                                .font(.nunito(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: detailVM.serviceCallAddRemoveFav) {
                                Image(systemName: detailVM.isFav ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .foregroundColor(Color.primaryApp)
                            
                        }
                        Text("\(detailVM.pObj.unitValue)\(detailVM.pObj.unitName), \(DataConstants.ProductDetail.price.localized)")
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Button {
                                detailVM.addSubQTY(isAdd: false)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .padding(8)
                            }
                            .foregroundColor(Color.primaryApp)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                            
                            Text( "\(detailVM.qty)")
                                .font(.nunito(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                                .frame(width: 45, height: 45, alignment: .center)
                            
                            Button {
                                detailVM.addSubQTY(isAdd: true)
                            } label: {
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .padding(8)
                            }
                            .foregroundColor(Color.primaryApp)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                            
                            Spacer()
                            
                            Text("\((detailVM.pObj.offerPrice ?? detailVM.pObj.price) * Double(detailVM.qty) , specifier: "%.0f")K")
                                .font(.nunito(.bold, fontSize: 28))
                                .foregroundColor(.primaryText)
                            
                        }
                        .padding(.vertical, 8)
                    }
                    .padding([.horizontal, .top])
                    
                    VStack{
                        HStack{
                            Text(DataConstants.ProductDetail.productDetails.localized)
                                .font(.nunito(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                withAnimation {
                                    detailVM.showDetail()
                                }
                            } label: {
                                Image(systemName: detailVM.isShowDetail ? "chevron.down" : "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                            }
                            .foregroundColor(Color.primaryText)
                        }
                        
                        if(detailVM.isShowDetail) {
                            Text(detailVM.pObj.detail)
                                .font(.nunito(.regular, fontSize: 13))
                                .foregroundColor(.secondaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom , 8)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        HStack{
                            Text(DataConstants.ProductDetail.nutrition.localized)
                                .font(.nunito(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                withAnimation {
                                    detailVM.showNutrition()
                                }
                                
                            } label: {
                                Image(systemName: detailVM.isShowNutrition ? "chevron.down" : "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                            }
                            .foregroundColor(Color.primaryText)
                        }
                        .padding(.vertical)
                        
                        if(detailVM.isShowNutrition) {
                            LazyVStack(spacing: 6) {
                                ForEach( detailVM.nutritionArr , id: \.id) { nObj in
                                    HStack{
                                        Text( nObj.nutritionName )
                                            .font(.nunito(.bold, fontSize: 15))
                                            .foregroundColor(.secondaryText)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text( nObj.nutritionValue )
                                            .font(.nunito(.bold, fontSize: 15))
                                            .foregroundColor(.primaryText)
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.horizontal)
                    
                    if detailVM.pObj.avgRating > 0 {
                        HStack{
                            Text(DataConstants.ProductDetail.review.localized)
                                .font(.nunito(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 2){
                                ForEach( 1...5 , id: \.self) { index in
                                    Image(systemName:  "star.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor( Color.orange)
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    RoundButton(title: DataConstants.ProductDetail.addToCart.localized) {
                        CartViewModel.serviceCallAddToCart(prodId: detailVM.pObj.prodId, qty: detailVM.qty) { isDone, msg  in
                            detailVM.qty = 1
                            
                            self.detailVM.errorMessage = msg
                            self.detailVM.showError = true
                        }
                    }
                    .padding()
                }
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.white)
                    .frame(width: 30, height: 30)
                    .padding(.top, .topInsets)
                    .padding(.leading)
            }
        }
        .alert(isPresented: $detailVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage), dismissButton: .default(Text(DataConstants.ProductDetail.ok.localized)))
        })
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProductDetailView(detailVM: ProductDetailViewModel(prodObj: ProductModel(dict: [
        "offer_price": 13,
        "start_date": "2024-05-05 00:00:00",
        "end_date": "2024-08-10 00:00:00",
        "prod_id": 5,
        "cat_id": 2,
        "name": "Dâu tây",
        "detail": "Dâu tây có màu đỏ sáng và hình dạng hạt trái tim. Chúng là nguồn cung cấp chất chống oxy hóa, vitamin C và mangan. Dâu tây thường được ăn sống, sử dụng trong làm sinh tố, mứt, và là thành phần của nhiều món tráng miệng.",
        "unit_name": "Kg",
        "unit_value": "1",
        "nutrition_weight": "100g",
        "price": 12,
        "image": "http://localhost:3001/img/product/202405132157375737xbGzdy1o35.jpg",
        "cat_name": "Hoa quả",
        "is_fav": 0
    ])))
}

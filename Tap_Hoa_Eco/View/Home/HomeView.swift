//
//  HomeView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeVM = HomeViewModel.shared
    @StateObject var explorVM = ExploreViewModel.shared
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            
            VStack {
                locationRealtime
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        BannerView()
                        
                        Text(DataConstants.Home.categories.localized)
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(explorVM.listArr) { eObj in
                                    NavigationLink(destination: ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: eObj))) {
                                        CategoryCell(eObj: eObj)
                                    }
                                }
                            }
                        }.padding(.bottom)
                        
                        Text(DataConstants.Home.specialOffers.localized)
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 8) {
                                ForEach (homeVM.offerArr) { pObj in
                                    ProductCell(pObj: pObj) {
                                        CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                            self.homeVM.errorMessage = msg
                                            self.homeVM.showError = true
                                        }
                                    }
                                    .padding(.horizontal, 5)
                                }
                            }
                        }
                        
                        Text(DataConstants.Home.bestSellers.localized)
                            .font(.nunito(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 8) {
                                ForEach (homeVM.bestArr) { pObj in
                                    ProductCell(pObj: pObj, didAddCart: {
                                        CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                            self.homeVM.errorMessage = msg
                                            self.homeVM.showError = true
                                        }
                                    })
                                    .padding(5)
                                }
                            }
                        }
                    }
                }
                .padding()
                .padding(.bottom, 24)
            }
        }
        .alert(isPresented: $homeVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(homeVM.errorMessage), dismissButton: .default(Text(DataConstants.Home.ok.localized)))
        })
    }
}

extension HomeView {
    private var locationRealtime: some View {
        VStack {
            HStack {
                Image(.location)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    
                Text(DataConstants.Home.location.localized)
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.white).opacity(0.75)
            }

            if locationManager.location != nil {
                Text("\(locationManager.address)")
                    .font(.nunito(.bold, fontSize: 16))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.bottom)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.primaryApp)
    }
}

#Preview {
    HomeView()
}

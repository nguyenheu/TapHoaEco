//
//  FavouriteView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct FavouriteView: View {
    @StateObject var favVM = FavouriteViewModel.shared
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack {
                ScrollView{
                    LazyVStack {
                        ForEach(favVM.listArr){ fObj in
                            NavigationLink(destination: ProductDetailView(detailVM: ProductDetailViewModel(prodObj: fObj))) {
                                FavouriteRow(fObj: fObj)
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                RoundButton(title: DataConstants.Favourite.addAllToCart.localized) {
                    CartViewModel.serviceCallAddAllToCart(products: favVM.listArr) { success, message in
                        errorMessage = message
                        showError = true
                    }
                }
            }
            .padding(.bottom, 60)
        }
        .navigationTitle(DataConstants.Favourite.title.localized)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.bgColor)
        .onAppear(perform: favVM.serviceCallList)
        .alert(isPresented: $showError) {
            Alert(title: Text(Globs.AppName),
                 message: Text(errorMessage),
                 dismissButton: .default(Text(DataConstants.Favourite.ok.localized)))
        }
    }
}

#Preview {
    FavouriteView()
}

//
//  ExploreItemsView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct ExploreItemsView: View {
    @StateObject var itemsVM = ExploreItemViewModel(catObj: ExploreCategoryModel (dict: [:]))
    
    var columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(itemsVM.listArr, id: \.id) {pObj in
                        ProductCell(pObj: pObj) {
                            CartViewModel.serviceCallAddToCart(prodId: pObj.prodId, qty: 1) { isDone, msg in
                                
                                self.itemsVM.errorMessage = msg
                                self.itemsVM.showError = true
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("\(itemsVM.cObj.name)")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
        }
        .alert(isPresented: $itemsVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(itemsVM.errorMessage), dismissButton: .default(Text("OK")) )
        }
    }
}

#Preview {
    ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [
        "cat_id": 1,
        "cat_name": "Rau củ",
        "image": "http://localhost:3001/img/category/20240426133809389zUIEuo3Vnn.png",
        "color": "F8A44C"
    ] ) ))
}

//
//  MainTabView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack{
            if(homeVM.selectTab == 0) {
                HomeView()
            }else if(homeVM.selectTab == 1) {
                ExploreView()
            }else if(homeVM.selectTab == 2) {
                CartView()
            }else if(homeVM.selectTab == 3) {
                FavouriteView()
            }else if(homeVM.selectTab == 4) {
                AccountView()
            }
            
            VStack{
                Spacer()
                
                HStack{
                    TabButton(title: DataConstants.MainTab.home.localized, icon: "house", isSelect: homeVM.selectTab == 0) {
                        DispatchQueue.main.async {
                            homeVM.selectTab = 0
                        }
                        
                    }
                    TabButton(title: DataConstants.MainTab.explore.localized, icon: "magnifyingglass", isSelect: homeVM.selectTab == 1) {
                        DispatchQueue.main.async {
                            homeVM.selectTab = 1
                        }
                    }
                    
                    TabButton(title: DataConstants.MainTab.cart.localized, icon: "cart", isSelect: homeVM.selectTab == 2) {
                        DispatchQueue.main.async {
                            homeVM.selectTab = 2
                        }
                    }
                    
                    TabButton(title: DataConstants.MainTab.favourite.localized, icon: "heart", isSelect: homeVM.selectTab == 3) {
                        DispatchQueue.main.async {
                            homeVM.selectTab = 3
                        }
                    }
                    
                    TabButton(title: DataConstants.MainTab.account.localized, icon: "person", isSelect: homeVM.selectTab == 4) {
                        DispatchQueue.main.async {
                            homeVM.selectTab = 4
                        }
                    }           
                }
                .padding(.top, 8)
                .padding(.horizontal)
                .padding(.bottom, 24)
                .background(Color.white)
                .cornerRadius(12)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    NavigationView {
//        MainTabView()
//    }
//}

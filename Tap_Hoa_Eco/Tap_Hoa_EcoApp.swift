//
//  Tap_Hoa_EcoApp.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

@main
struct Tap_Hoa_EcoApp: App {
    @StateObject private var mainVM = MainViewModel.shared
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.bgColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.primaryApp)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.primaryApp)]
       
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if mainVM.isUserLogin {
                    MainTabView()
                } else {
                    OnboardingView()
                }
            }
            .tint(Color.primaryApp)
        }
    }
}

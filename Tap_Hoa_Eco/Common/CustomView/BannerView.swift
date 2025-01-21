//
//  IntroView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 2/11/24.
//

import SwiftUI

struct BannerView: View {
    @State private var selectedBanner = 0
    
    let images = ["banner1", "banner2", "banner3"]
    
    // Timer to change the tab every 3 seconds
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            TabView(selection: $selectedBanner) {
                ForEach(0..<images.count, id: \.self) { index in
                    VStack {
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // hide default indicator
            .frame(height: 144)
            .onReceive(timer) { _ in
                withAnimation {
                    selectedBanner = (selectedBanner + 1) % images.count
                }
            }
            
            HStack(spacing: 8) {
                ForEach(0..<images.count, id: \.self) { indicatorIndex in
                    if indicatorIndex == selectedBanner {
                        Capsule()
                            .frame(width: 24, height: 8)
                            .foregroundColor(Color.primaryApp)
                    } else {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

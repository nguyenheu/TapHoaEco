//
//  OnboardingView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isLogin = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.groBg)
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            Color.black.opacity(0.5)
            
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                
                Text(DataConstants.Onboarding.title.localized)
                    .font(.nunito(.bold, fontSize: 36))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                Text(DataConstants.Onboarding.subtitle.localized)
                    .font(.nunito(.bold, fontSize: 16))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                                
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLogin.toggle()
                    }
                } label: {
                    Text(DataConstants.Onboarding.startButton.localized)
                        .font(.nunito(.bold, fontSize: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .background(Color.primaryApp)
                .cornerRadius(12)
                .padding()
                .fullScreenCover(isPresented: $isLogin) {
                    LoginView()
                }
            }
            .padding(.bottom, 60)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}

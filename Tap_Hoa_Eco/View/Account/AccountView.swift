//
//  AccountView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var myVM = MyDetailsViewModel.shared
    @StateObject private var mainVM = MainViewModel.shared
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    if let profileImage = myVM.profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.7))
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(myVM.txtUsername)
                            .font(.nunito(.bold, fontSize: 20))
                        
                        Text(myVM.txtEmail)
                            .font(.nunito(.regular, fontSize: 16))
                    }
                    .foregroundStyle(Color.white)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .padding(.top, 60)
                .background(Color.primaryApp)
          
                ScrollView {
                    LazyVStack {
                        NavigationLink {
                            MyOrdersView()
                        } label: {
                            AccountRow(accountItem: .order)
                        }
                        
                        NavigationLink {
                            MyDetailsView()
                        } label: {
                            AccountRow(accountItem: .idCard)
                        }

                        NavigationLink {
                            DeliveryAddressView()
                        } label: {
                            AccountRow(accountItem: .location)
                        }
                        
                        NavigationLink {
                            PaymentMethodsView()
                        } label: {
                            AccountRow(accountItem: .paymentCard)
                        }

                        NavigationLink {
                            PromoCodeView()
                        } label: {
                            AccountRow(accountItem: .promoCode)
                        }
                        NavigationLink {
                            NotificationView()
                        } label: {
                            AccountRow(accountItem: .bell)
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    if mainVM.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.vertical, 2.5)
                    } else {
                        Text(DataConstants.Account.logout.localized)
                            .font(.nunito(.bold, fontSize: 18))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "power")
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.primaryApp)
                .clipShape(.rect(cornerRadius: 12))
                .frame(maxWidth: .infinity)
                .padding()
                .onTapGesture {
                    MainViewModel.shared.logout()
                }
                .padding(.bottom, 92)
            }
            .background(Color.bgColor)
        }
        .ignoresSafeArea()
    }
}
#Preview {
    AccountView()
}

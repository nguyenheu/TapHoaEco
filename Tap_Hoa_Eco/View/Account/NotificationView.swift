//
//  NotificationView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var notiVM = NotificationViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(notiVM.listArr , id: \.id){ nObj in
                        VStack{
                            HStack {
                                Text(nObj.title)
                                    .font(.nunito(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(nObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.nunito(.regular, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                            }
                            
                            Text(nObj.message)
                                .font(.nunito(.bold, fontSize: 14))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment( .leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .background(nObj.isRead == 1 ? Color.placeholder : Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.15), radius: 2)
                    }
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(DataConstants.Notification.title.localized)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        notiVM.serviceCallReadAll()
                    } label: {
                        Text(DataConstants.Notification.readAll.localized)
                            .font(.nunito(.bold, fontSize: 16))
                    }
                }
            }
        }
        .alert(isPresented: $notiVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(notiVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
    }
}

#Preview {
    NotificationView()
}

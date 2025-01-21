//
//  WriteReviewView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 19/7/24.
//

import SwiftUI

struct WriteReviewView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm : MyOrderDetailViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Text(DataConstants.Review.thankYouMessage.localized)
                .font(.nunito(.regular, fontSize: 18))
                .foregroundStyle(Color.primaryApp)
                .multilineTextAlignment(.leading)

            HStack(spacing: 15) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(index <= vm.rating ? Color.orange : Color.black.opacity(0.2))
                        .frame(width: .widthPer(per: 0.1), height: .widthPer(per: 0.1))
                        .onTapGesture {
                            vm.rating = index
                        }
                }
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $vm.txtMessage)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(Color.primaryApp)
                    .focused($isFocused)
                    .padding(.horizontal)
                    .frame(height: 300)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(Color.bgColor)
                            RoundedRectangle(cornerRadius: 10).stroke(Color.primaryApp, lineWidth: 1)
                        }
                    )
                
                if vm.txtMessage.isEmpty && !isFocused {
                    Text(DataConstants.Review.writePlaceholder.localized)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .foregroundStyle(Color.primaryText)
                }
            }
            
            RoundButton(title: DataConstants.Review.submit.localized) {
                vm.serviceCallWriteReview {
                    dismiss()
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.bgColor.ignoresSafeArea())
        .navigationTitle(DataConstants.Review.title.localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

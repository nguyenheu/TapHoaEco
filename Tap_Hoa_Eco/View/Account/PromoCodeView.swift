//
//  PromoCodeView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var promoVM = PromoCodeViewModel()
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: PromoCodeModel) -> () )?
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach( promoVM.listArr , id: \.id, content: {pObj in
                        VStack{
                            HStack {
                                Text(pObj.title)
                                    .font(.nunito(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(pObj.code)
                                    .font(.nunito(.bold, fontSize: 15))
                                    .foregroundColor(.primaryApp)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.secondaryText.opacity(0.3))
                                    .cornerRadius(5)
                            }
                            
                            Text(pObj.description)
                                .font(.nunito(.bold, fontSize: 14))
                                .foregroundColor(.secondaryText)
                                .multilineTextAlignment( .leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            HStack{
                                Text(DataConstants.PromoCode.validUntil.localized)
                                    .font(.nunito(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)
                                    
                                
                                Text( pObj.endDate.displayDate(format: "yyyy-MM-dd hh:mm a") )
                                    .font(.nunito(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if(isPicker) {
                                dismiss()
                                didSelect?(pObj)
                            }
                        }
                    })
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.PromoCode.title.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PromoCodeView()
}

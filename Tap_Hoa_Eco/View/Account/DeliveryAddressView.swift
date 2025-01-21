//
//  DeliveryAddressView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct DeliveryAddressView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: AddressModel) -> () )?
    
    var body: some View {
        ZStack {
            ScrollView{
                LazyVStack(spacing: 15) {
                    ForEach(addressVM.listArr , id: \.id) { aObj in
                        HStack(spacing: 15) {
                            VStack{
                                HStack {
                                    Text(aObj.name)
                                        .font(.nunito(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(aObj.typeName)
                                        .font(.nunito(.bold, fontSize: 12))
                                        .foregroundColor(.primaryText)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.secondaryText.opacity(0.3))
                                        .cornerRadius(5)
                                }
                                Text("\(aObj.address),\(aObj.city)")
                                    .font(.nunito(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .multilineTextAlignment( .leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(aObj.phone)
                                    .font(.nunito(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack{
                                Button {
                                    addressVM.serviceCallRemove(cObj: aObj)
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color.primaryApp)
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                }
                                
                                Spacer()
                                
                                NavigationLink {
                                    AddDeliveryAddressView(isEdit: true, editObj: aObj  )
                                } label: {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .foregroundColor(.primaryApp)
                                }
                                .padding(.bottom, 8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if(isPicker) {
                                dismiss()
                                didSelect?(aObj)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.DeliveryAddress.title.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddDeliveryAddressView()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
#Preview {
    DeliveryAddressView()
}

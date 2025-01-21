//
//  AddDeliveryAddressView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

struct AddDeliveryAddressView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isEdit: Bool = false
    @State var editObj: AddressModel?
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack(spacing: 16){
                    HStack{
                        Button {
                            addressVM.txtTypeName = DataConstants.DeliveryAddress.home.localized
                        } label: {
                            Image(systemName: addressVM.txtTypeName == DataConstants.DeliveryAddress.home ? "record.circle" : "circle")
                                .foregroundStyle(addressVM.txtTypeName == DataConstants.DeliveryAddress.home ? Color.primaryApp : Color.primaryText)
                                
                            Text(DataConstants.DeliveryAddress.home)
                                .font(.nunito(.bold, fontSize: 16))
                                .foregroundStyle(addressVM.txtTypeName == DataConstants.DeliveryAddress.home ? Color.primaryApp : Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Button {
                            addressVM.txtTypeName = DataConstants.DeliveryAddress.office.localized
                        } label: {
                            Image(systemName: addressVM.txtTypeName == DataConstants.DeliveryAddress.office ? "record.circle" : "circle")
                                .foregroundStyle(addressVM.txtTypeName == DataConstants.DeliveryAddress.office ? Color.primaryApp : Color.primaryText)
                                
                            Text(DataConstants.DeliveryAddress.office)
                                .font(.nunito(.bold, fontSize: 16))
                                .foregroundStyle(addressVM.txtTypeName == DataConstants.DeliveryAddress.office ? Color.primaryApp : Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading )
                        }
                    }.foregroundColor(.primaryText)
                    
                    CustomTextField(
                        title: DataConstants.DeliveryAddress.name.localized,
                        placeholder: DataConstants.DeliveryAddress.namePlaceholder.localized,
                        txt: $addressVM.txtName
                    )
                    
                    CustomTextField(
                        title: DataConstants.DeliveryAddress.phone.localized,
                        placeholder: DataConstants.DeliveryAddress.phonePlaceholder.localized,
                        txt: $addressVM.txtMobile,
                        keyboardType: .numberPad
                    )
                    
                    CustomTextField(
                        title: DataConstants.DeliveryAddress.address.localized,
                        placeholder: DataConstants.DeliveryAddress.addressPlaceholder.localized,
                        txt: $addressVM.txtAddress
                    )
                    
                    RoundButton(
                        title: isEdit ? DataConstants.DeliveryAddress.updateAddress.localized :
                            DataConstants.DeliveryAddress.addAddress.localized
                    ) {
                        if(isEdit) {
                            addressVM.serviceCallUpdateAddress(aObj: editObj) {
                                dismiss()
                            }
                        }else{
                            addressVM.serviceCallAddAddress {
                                dismiss()
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(
                isEdit ? DataConstants.DeliveryAddress.editAddress.localized :
                    DataConstants.DeliveryAddress.addAddress.localized
            )
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            if(isEdit) {
                if let aObj = editObj {
                    addressVM.setData(aObj: aObj)
                }
            }
        }
        .alert(isPresented: $addressVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(addressVM.errorMessage), dismissButton: .default(Text(DataConstants.DeliveryAddress.ok.localized)))
        }
    }
}

#Preview {
    AddDeliveryAddressView()
}

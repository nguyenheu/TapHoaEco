//
//  MyDetailsView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI
import CountryPicker
import PhotosUI

struct MyDetailsView: View {
    @StateObject var myVM = MyDetailsViewModel.shared
    @StateObject private var mainVM = MainViewModel.shared
    
    @State private var isEditingName = false
    @State private var isEditingUsername = false
    @State private var isEditingPhone = false

    var body: some View {
        ZStack {
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    if let profileImage = myVM.tempProfileImage ?? myVM.profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.7))
                            .frame(width: 80, height: 80)
                    }
                    
                    PhotosPicker(selection: $myVM.selectedItem,
                               matching: .images) {
                        Image(systemName: "camera")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                }
                .frame(height: 100)
                .onChange(of: myVM.selectedItem) { _ in
                    myVM.loadImage()
                }
                    
                VStack {
                    VStack {
                        HStack {
                            Text(DataConstants.Profile.fullName.localized)
                            
                            if isEditingName || myVM.txtName.isEmpty {
                                TextField(DataConstants.Profile.fullNamePlaceholder.localized, text: $myVM.txtName)
                                    .keyboardType(.default)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.gray)
                            } else {
                                Spacer()
                                
                                Text(myVM.txtName)
                                    .font(.nunito(.regular, fontSize: 16))
                                    .foregroundColor(.primaryText)
                                
                                Button {
                                    isEditingName.toggle()
                                } label: {
                                    Image(.icPencil)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16)
                                }
                            }
                        }
                        .foregroundStyle(Color.primaryText)

                        Divider()
                    }
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text(DataConstants.Profile.username.localized)
                            
                            if isEditingUsername || myVM.txtUsername.isEmpty {
                                TextField(DataConstants.Profile.usernamePlaceholder.localized, text: $myVM.txtUsername)
                                    .keyboardType(.default)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.gray)
                            } else {
                                Spacer()
                                
                                Text(myVM.txtUsername)
                                    .font(.nunito(.regular, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                Button {
                                    isEditingUsername.toggle()
                                } label: {
                                    Image(.icPencil)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16)
                                }

                            }
                        }
                        .foregroundStyle(Color.primaryText)
                        
                        Divider()
                    }
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text(DataConstants.Profile.email.localized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(myVM.txtEmail)
                                .font(.nunito(.regular, fontSize: 18))
                        }
                        .foregroundStyle(Color.primaryText)
                        
                        Divider()
                    }
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text(DataConstants.Profile.phone.localized)
                            
                            if isEditingPhone || myVM.txtMobile.isEmpty {
                                HStack {
                                    Button {
                                        myVM.isShowPicker = true
                                    } label: {
                                        if let countryObj = myVM.countryObj {
                                            
                                            Text( "\( countryObj.isoCode.getFlag())")
                                                .font(.nunito(.medium, fontSize: 18))
                                                                          
                                            Text( "+\(countryObj.phoneCode)")
                                                .font(.nunito(.medium, fontSize: 18))
                                                .foregroundColor(.primaryText)
                                        }
                                    }
                                    
                                    TextField(DataConstants.Profile.phonePlaceholder.localized, text: $myVM.txtMobile)
                                        .keyboardType(.numberPad)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                }
                            } else {
                                Spacer()
                                HStack {
                                    Button {
                                        myVM.isShowPicker = true
                                    } label: {
                                        if let countryObj = myVM.countryObj {
                                            
                                            Text( "\( countryObj.isoCode.getFlag())")
                                                .font(.nunito(.medium, fontSize: 18))
                                                                          
                                            Text( "+\(countryObj.phoneCode)")
                                                .font(.nunito(.medium, fontSize: 18))
                                                .foregroundColor(.primaryText)
                                        }
                                    }
                                    
                                    Text(myVM.txtMobile)
                                        .font(.nunito(.regular, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                    Button {
                                        isEditingPhone.toggle()
                                    } label: {
                                        Image(.icPencil)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16)
                                    }
                                }
                            }
                        }
                        .foregroundStyle(Color.primaryText)
                        
                        Divider()
                    }
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text(DataConstants.Profile.password.localized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("******")
                                .font(.nunito(.regular, fontSize: 16))
                                .foregroundColor(.primaryText)
                                     
                            NavigationLink {
                                ChangePasswordView()
                            } label: {
                                Image(.icPencil)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16)
                            }
                        }
                        .foregroundStyle(Color.primaryText)
                        
                        Divider()
                    }
                    .padding(.top)
   
                    RoundButton(title: DataConstants.Profile.update.localized) {
                        myVM.serviceCallUpdate()
                    }
                    
                    NavigationLink {
                        ChangePasswordView()
                    } label: {
                        Text(DataConstants.Profile.changePassword.localized)
                            .font(.nunito(.bold, fontSize: 18))
                            .foregroundColor(.primaryApp)
                            .padding(.vertical)
                            .frame(maxWidth: .screenWidth - 64)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.primaryApp, lineWidth: 1)
                            }
                    }
                }
            }
            .padding()
            .background(Color.bgColor)
            .navigationTitle(DataConstants.Profile.title.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            myVM.onUpdateSuccess = {
                withAnimation(.spring) {
                    isEditingName = false
                    isEditingUsername = false
                    isEditingPhone = false
                }
            }
        }
        .sheet(isPresented: $myVM.isShowPicker, content: {
            CountryPickerUI(country: $myVM.countryObj)
        })
        .alert(isPresented: $myVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(myVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
    }
}

#Preview {
    MyDetailsView()
}

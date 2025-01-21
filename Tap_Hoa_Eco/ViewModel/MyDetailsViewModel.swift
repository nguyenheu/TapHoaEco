//
//  MyDetailsViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import SwiftUI
import CountryPicker
import PhotosUI

class MyDetailsViewModel: ObservableObject {
    static var shared: MyDetailsViewModel = MyDetailsViewModel()
    
    @Published var txtName: String = ""
    @Published var txtMobile: String = ""
    @Published var txtUsername: String = ""
    @Published var txtMobileCode: String = ""
    @Published var txtEmail: String = ""
    @Published var isShowPicker: Bool = false
    @Published var currentIsoCode: String = "VN"
    @Published var countryObj: Country? {
        didSet {
            if let countryObj = countryObj {
                txtMobileCode = "+\(countryObj.phoneCode)"
                currentIsoCode = countryObj.isoCode // Lưu lại isoCode khi người dùng chọn
            }
        }
    }
    
    @Published var txtCurrentPassword: String = ""
    @Published var txtNewPassword: String = ""
    @Published var txtConfirmPassword: String = ""
    
    @Published var isCurrentPassword: Bool = false
    @Published var isNewPassword: Bool = false
    @Published var isConfirmPassword: Bool = false
    
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [AddressModel] = []
    
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var profileImage: UIImage? = nil
    
    @Published var tempProfileImage: UIImage? = nil
    @Published var tempImageData: Data? = nil
    
    private let imageKey = "user_profile_image"
    var onUpdateSuccess: (() -> Void)?
    
    init() {
        setData()
        
    }
    
    func loadImage() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            if let selectedItem = selectedItem,
               let data = try? await selectedItem.loadTransferable(type: Data.self) {
                self.tempImageData = data
                self.tempProfileImage = UIImage(data: data)
            }
        }
    }
    
    private func loadSavedImage() {
        // Remove optional binding since id is non-optional
        let userId = MainViewModel.shared.userObj.id
        if let imageData = UserDefaults.standard.data(forKey: "\(imageKey)_\(userId)") {
            self.selectedImageData = imageData
            self.profileImage = UIImage(data: imageData)
        }
    }
    
    func clearUserImage() {
        // Remove optional binding since id is non-optional
        let userId = MainViewModel.shared.userObj.id
        UserDefaults.standard.removeObject(forKey: "\(imageKey)_\(userId)")
        self.selectedImageData = nil
        self.profileImage = nil
        
        self.tempProfileImage = nil
        self.tempImageData = nil
        self.selectedItem = nil      
    }
    
    func clearAll(){
        txtName = ""
        txtMobile = ""
        txtUsername = ""
        txtCurrentPassword = ""
        txtMobileCode = ""
        txtNewPassword = ""
        txtConfirmPassword = ""
        
        clearUserImage()
    }
    
    func setData() {
        let userObj = MainViewModel.shared.userObj
        txtName = userObj.name
        txtMobile = userObj.mobile
        txtMobileCode = userObj.mobileCode
        txtUsername = userObj.username
        txtEmail = userObj.email
        
        self.countryObj = Country(phoneCode: txtMobileCode.replacingOccurrences(of: "+", with: ""), isoCode: currentIsoCode)
        loadSavedImage()
    }
    
    
    
    //MARK: - Cập nhật thông tin người dùng
    func serviceCallUpdate(){
        var params: [String: Any] = [
            "name": txtName.trimmingCharacters(in: .whitespacesAndNewlines),
            "mobile": txtMobile,
            "mobile_code": txtMobileCode,
            "username": txtUsername
        ]
        
        // Kiểm tra và làm sạch khoảng trắng ở tên
        let trimmedName = txtName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedName.isEmpty {
            self.errorMessage = "Vui lòng nhập tên"
            self.showError = true
            return
        }
        
        // Tên phải có ít nhất 2 ký tự
        if trimmedName.count < 2 {
            self.errorMessage = "Tên phải có ít nhất 2 ký tự"
            self.showError = true
            return
        }
        
        // Kiểm tra định dạng số điện thoại (từ 9-12 số)
        let phoneNumberPattern = "^[0-9]{9,12}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberPattern)
        if !phonePredicate.evaluate(with: txtMobile) {
            self.errorMessage = "Số điện thoại không hợp lệ (phải có 9-12 số)"
            self.showError = true
            return
        }
        
        // Kiểm tra định dạng username (4-20 ký tự, chữ cái, số và dấu gạch dưới)
        let usernamePattern = "^[a-zA-Z0-9_]{4,20}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernamePattern)
        if !usernamePredicate.evaluate(with: txtUsername) {
            self.errorMessage = "Username phải từ 4-20 ký tự, chỉ bao gồm chữ cái, số và dấu gạch dưới"
            self.showError = true
            return
        }
        
        if let imageData = tempImageData {
            params["profile_image"] = imageData.base64EncodedString()
        }
        
        // Gọi API cập nhật thông tin
        ServiceCall.post(parameter: params, path: Globs.SV_UPDATE_PROFILE, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    if let payload = response.value(forKey: KKey.payload) as? NSDictionary {
                        MainViewModel.shared.setUserData(uDict: payload)
                    }
                    
                    if let imageData = self.tempImageData {
                         let userId = MainViewModel.shared.userObj.id
                         UserDefaults.standard.set(imageData, forKey: "\(self.imageKey)_\(userId)")
                         self.profileImage = self.tempProfileImage
                         self.selectedImageData = self.tempImageData
                     }
                    
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showError = true
                    
                    DispatchQueue.main.async {
                        self.onUpdateSuccess?()
                    }
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
    
    //MARK: - Đổi mật khẩu
    func serviceCallChangePassword(){
        
        // Kiểm tra mật khẩu hiện tại
        if txtCurrentPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.errorMessage = "Vui lòng nhập mật khẩu hiện tại"
            self.showError = true
            return
        }
        
        // Kiểm tra định dạng mật khẩu mới (ít nhất 6 ký tự, phải có cả chữ và số)
        let passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        
        if !passwordPredicate.evaluate(with: txtNewPassword) {
            self.errorMessage = "Mật khẩu mới phải có ít nhất 6 ký tự, bao gồm cả chữ và số"
            self.showError = true
            return
        }
        
        // Kiểm tra mật khẩu mới không trùng với mật khẩu cũ
        if txtNewPassword == txtCurrentPassword {
            self.errorMessage = "Mật khẩu mới không được giống mật khẩu hiện tại"
            self.showError = true
            return
        }
        
        // Kiểm tra xác nhận mật khẩu
        if txtNewPassword != txtConfirmPassword {
            self.errorMessage = "Mật khẩu xác nhận không khớp"
            self.showError = true
            return
        }
        
        // Gọi API đổi mật khẩu
        ServiceCall.post(parameter: ["current_password": txtCurrentPassword, "new_password": txtNewPassword], path: Globs.SV_CHANGE_PASSWORD, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.txtConfirmPassword = ""
                    self.txtNewPassword = ""
                    self.txtCurrentPassword = ""
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                    self.showError = true
                    
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }
    }
}

//
//  LoginViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 14/04/2024.
//

import SwiftUI
import Network

class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    // MARK: - Published Properties
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    
    @Published var isShowPassword: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])
    @Published var isSignUpSuccessful: Bool = false
    
    @Published var isLoading: Bool = false // Hiển thị loading indicator
    
    // MARK: - Network Monitor
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    // MARK: - Initializer
    private init() {
        // Khởi động Network Monitor
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status != .satisfied {
                    self?.showError(message: .networkUnavailable)
                }
            }
        }
        monitor.start(queue: queue)
        
        // Kiểm tra trạng thái đăng nhập từ UserDefaults
        if Utils.UDValueBool(key: Globs.userLogin) {
            let payload = Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:]
            self.setUserData(uDict: payload)
        }
        
        #if DEBUG
        // Dữ liệu mẫu cho quá trình phát triển
        txtUsername = "Mathew"
        txtEmail = "test@gmail.com"
        txtPassword = "123456"
        #endif
    }
    
    // MARK: - Logout
    func logout() {
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            MyDetailsViewModel.shared.clearUserImage()
            Utils.UDSET(data: false, key: Globs.userLogin)
            self.isUserLogin = false
            self.isLoading = false
        }
    }
    
    // MARK: - Service Call Login
    func serviceCallLogin() {
        // Reset trạng thái lỗi và bắt đầu quá trình đăng nhập
        self.showError = false
        self.errorMessage = ""
        self.isLoading = true
        
        // Xác thực đầu vào
        do {
            try validateLoginInputs()
        } catch let error as LoginError {
            self.showError(message: error)
            self.isLoading = false
            return
        } catch {
            self.showError(message: .unknownError)
            self.isLoading = false
            return
        }
        
        // Thực hiện gọi API đăng nhập
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtPassword, "dervice_token": ""], path: Globs.SV_LOGIN) { [weak self] responseObj in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                guard let self = self else { return }
                self.isLoading = false
                if let response = responseObj as? NSDictionary {
                    let status = response.value(forKey: KKey.status) as? String ?? "0"
                    let message = response.value(forKey: KKey.message) as? String ?? ""
                    if status == "1" {
                        let payload = response.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                        self.setUserData(uDict: payload)
                    } else if status == "2" {
                        // Ví dụ: Tài khoản chưa được kích hoạt
                        self.showError(message: .serverError(message))
                    } else if status == "3" {
                        // Ví dụ: Tài khoản bị khóa
                        self.showError(message: .serverError(message))
                    } else {
                        // Lỗi xác thực
                        self.showError(message: .authenticationFailed)
                    }
                } else {
                    self.showError(message: .unknownError)
                }
            }
        } failure: { [weak self] error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                guard let self = self else { return }
                self.isLoading = false
                if let error = error as NSError? {
                    if error.domain == NSURLErrorDomain {
                        self.showError(message: .networkUnavailable)
                    } else {
                        self.showError(message: .unknownError)
                    }
                } else {
                    self.showError(message: .unknownError)
                }
            }
        }
    }
    
    // MARK: - Service Call SignUp
    func serviceCallSignUp() {
        // Reset trạng thái lỗi và bắt đầu quá trình đăng ký
        self.showError = false
        self.errorMessage = ""
        self.isLoading = true
        
        // Xác thực đầu vào
        do {
            try validateSignUpInputs()
        } catch let error as LoginError {
            self.showError(message: error)
            self.isLoading = false
            return
        } catch {
            self.showError(message: .unknownError)
            self.isLoading = false
            return
        }
        
        // Thực hiện gọi API đăng ký
        ServiceCall.post(parameter: [
            "username": txtUsername,
            "email": txtEmail,
            "password": txtPassword,
            "dervice_token": ""
        ], path: Globs.SV_SIGN_UP) { [weak self] responseObj in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                if let response = responseObj as? NSDictionary {
                    let status = response.value(forKey: KKey.status) as? String ?? "0"
                    let message = response.value(forKey: KKey.message) as? String ?? ""
                    if status == "1" {                        self.isSignUpSuccessful = true
                    } else {
                        self.showError(message: .serverError(message))
                    }
                } else {
                    self.showError(message: .unknownError)
                }
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                if let error = error as NSError? {
                    if error.domain == NSURLErrorDomain {
                        self.showError(message: .networkUnavailable)
                    } else {
                        self.showError(message: .unknownError)
                    }
                } else {
                    self.showError(message: .unknownError)
                }
            }
        }
    }
    
    // MARK: - Validate Login Inputs
    private func validateLoginInputs() throws {
        // Kiểm tra email không để trống
        if txtEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw LoginError.emptyEmail
        }
        
        // Kiểm tra định dạng email
        if !txtEmail.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        // Kiểm tra mật khẩu không để trống
        if txtPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw LoginError.emptyPassword
        }
        
        // Kiểm tra độ dài mật khẩu (ví dụ: tối thiểu 6 ký tự)
        if txtPassword.count < 6 {
            throw LoginError.weakPassword
        }
    }
    
    // MARK: - Validate SignUp Inputs
    private func validateSignUpInputs() throws {
        // Kiểm tra tên người dùng không để trống
        if txtUsername.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw LoginError.emptyUsername
        }
        
        // Kiểm tra email không để trống
        if txtEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw LoginError.emptyEmail
        }
        
        // Kiểm tra định dạng email
        if !txtEmail.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        // Kiểm tra mật khẩu không để trống
        if txtPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw LoginError.emptyPassword
        }
        
        // Kiểm tra độ dài mật khẩu (tối thiểu 6 ký tự)
        if txtPassword.count < 6 {
            throw LoginError.weakPassword
        }
    }
    
    // MARK: - Set User Data
    func setUserData(uDict: NSDictionary) {
        Utils.UDSET(data: uDict, key: Globs.userPayload)
        Utils.UDSET(data: true, key: Globs.userLogin)
        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        
        HomeViewModel.shared.selectTab = 0
        
        // Reset các trường nhập liệu
        self.txtUsername = ""
        self.txtEmail = ""
        self.txtPassword = ""
        self.isShowPassword = false
    }
    
    // MARK: - Show Error
    private func showError(message: LoginError) {
        self.errorMessage = message.localizedDescription
        self.showError = true
    }
}

// MARK: - Extension for SignUp Input Validation
extension LoginError {
    static let emptyUsername = LoginError.serverError("Vui lòng nhập tên người dùng.")
}

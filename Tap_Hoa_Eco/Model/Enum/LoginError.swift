//
//  LoginError.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 3/11/24.
//

import Foundation

enum LoginError: LocalizedError {
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case weakPassword
    case networkUnavailable
    case serverError(String)
    case authenticationFailed
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Vui lòng nhập địa chỉ email."
        case .invalidEmail:
            return "Địa chỉ email không hợp lệ."
        case .emptyPassword:
            return "Vui lòng nhập mật khẩu."
        case .weakPassword:
            return "Mật khẩu phải có ít nhất 6 ký tự."
        case .networkUnavailable:
            return "Không có kết nối Internet. Vui lòng kiểm tra lại."
        case .serverError(let message):
            return message.isEmpty ? "Máy chủ đang gặp sự cố. Vui lòng thử lại sau." : message
        case .authenticationFailed:
            return "Email hoặc mật khẩu không chính xác."
        case .unknownError:
            return "Đã xảy ra lỗi. Vui lòng thử lại."
        }
    }
}

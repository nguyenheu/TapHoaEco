//
//  PaymentViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import Foundation

class PaymentViewModel: ObservableObject {
    static var shared: PaymentViewModel = PaymentViewModel()
    
    @Published var txtName: String = ""
    @Published var txtCardNumber: String = ""
    @Published var txtCardMonth: String = ""
    @Published var txtCardYear: String = ""
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var listArr: [PaymentModel] = []
    
    // Lấy số thẻ đã loại bỏ khoảng trắng
    var rawCardNumber: String {
        txtCardNumber.replacingOccurrences(of: " ", with: "")
    }
    
    init() {
        serviceCallList()
    }
    
    func clearAll(){
        txtName = ""
        txtCardNumber = ""
        txtCardYear = ""
        txtCardMonth = ""
        
    }
    
    //MARK: ServiceCall
    //Lấy danh sách thẻ từ server
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_PAYMENT_METHOD_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    //Chuyển đổi dữ liệu API thành mảng PaymentModel
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return PaymentModel(dict: obj as? NSDictionary ?? [:])
                    })
                
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
    
    //Xoá thẻ khỏi danh sách
    func serviceCallRemove(pObj: PaymentModel){
        ServiceCall.post(parameter: ["pay_id": pObj.id ], path: Globs.SV_REMOVE_PAYMENT_METHOD, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    //Cập nhật lại danh sách sau khi xoá thành công
                    self.serviceCallList()
                
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
    
    //Thêm thẻ mới
    func serviceCallAdd(didDone: (() -> ())?) {
        // Kiểm tra tên chủ thẻ hợp lệ
        func isValidName() -> Bool {
            let trimmedName = txtName.trimmingCharacters(in: .whitespacesAndNewlines)
            let nameRegex = "^[\\p{L} ]+$" // Regex cho phép chữ cái Unicode và khoảng trắng
            let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            return !trimmedName.isEmpty &&
                   trimmedName.count >= 2 &&
                   namePredicate.evaluate(with: trimmedName)
        }
        
        // Kiểm tra số thẻ hợp lệ (16 số)
        func isValidCardNumber() -> Bool {
            let cleanNumber = rawCardNumber
            return cleanNumber.count == 16 && cleanNumber.allSatisfy { $0.isNumber }
        }
        
        // Kiểm tra tháng hết hạn hợp lệ (01-12)
        func isValidMonth() -> Bool {
            guard let month = Int(txtCardMonth),
                  txtCardMonth.count == 2 else { return false }
            return (1...12).contains(month)
        }
        
        // Kiểm tra năm hết hạn hợp lệ (từ năm hiện tại đến 10 năm sau)
        func isValidYear() -> Bool {
            guard let year = Int(txtCardYear),
                  txtCardMonth.count == 2,
                  txtCardYear.count == 4 else { return false }
            
            let currentYear = Calendar.current.component(.year, from: Date())
            return year >= currentYear && year <= currentYear + 10
        }
        
        // Kiểm tra thẻ đã hết hạn chưa
        func isCardExpired() -> Bool {
            guard let month = Int(txtCardMonth),
                  let year = Int(txtCardYear) else { return true }
            
            let currentYear = Calendar.current.component(.year, from: Date())
            let currentMonth = Calendar.current.component(.month, from: Date())
            
            return year < currentYear || (year == currentYear && month < currentMonth)
        }
        
        func showErrorMessage(_ message: String) {
            errorMessage = message
            showError = true
        }
        
        guard isValidName() else {
            showErrorMessage("Vui lòng nhập tên chủ thẻ hợp lệ")
            return
        }
        
        guard isValidCardNumber() else {
            showErrorMessage("Số thẻ không hợp lệ. Vui lòng nhập 16 chữ số")
            return
        }
        
        guard isValidMonth() else {
            showErrorMessage("Tháng không hợp lệ. Vui lòng nhập từ 01-12")
            return
        }
        
        guard isValidYear() else {
            showErrorMessage("Năm không hợp lệ. Vui lòng nhập năm từ hiện tại đến 10 năm")
            return
        }
        
        guard !isCardExpired() else {
            showErrorMessage("Thẻ đã hết hạn")
            return
        }
        
        let parameters: [String: Any] = [
            "name": txtName.trimmingCharacters(in: .whitespacesAndNewlines),
            "card_number": rawCardNumber,
            "card_month": txtCardMonth,
            "card_year": txtCardYear
        ]
        
        ServiceCall.post(parameter: parameters,
                        path: Globs.SV_ADD_PAYMENT_METHOD,
                        isToken: true) { [weak self] responseObj in
            guard let self = self else { return }
            
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.clearAll()
                    self.serviceCallList()
                    didDone?()
                } else {
                    showErrorMessage(response.value(forKey: KKey.message) as? String ?? "Thêm thẻ thất bại")
                }
            }
        } failure: { error in
            showErrorMessage(error?.localizedDescription ?? "Lỗi kết nối")
        }
    }
    
}

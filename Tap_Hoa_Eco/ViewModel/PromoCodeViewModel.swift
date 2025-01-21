//
//  PromoCodeViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import Foundation
class PromoCodeViewModel: ObservableObject {
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var listArr: [PromoCodeModel] = []
    @Published var isLoading = false
    
//    init() {
//        serviceCallList()
//    }
    
    //MARK: ServiceCall
    func serviceCallList() {
        isLoading = true
        ServiceCall.post(parameter: [:], path: Globs.SV_PROMO_CODE_LIST, isToken: true) { [weak self] responseObj in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                            return PromoCodeModel(dict: obj as? NSDictionary ?? [:])
                        })
                    } else {
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                        self.showError = true
                    }
                }
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                self.errorMessage = error?.localizedDescription ?? "Fail"
                self.showError = true
            }
        }
    }
}

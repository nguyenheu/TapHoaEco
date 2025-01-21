//
//  MyOrdersViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 06/05/2024.
//

import Foundation
class MyOrdersViewModel: ObservableObject {
    static var shared: MyOrdersViewModel = MyOrdersViewModel()
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [MyOrderModel] = []
    
    
    init() {
        serviceCallList()
    }
    
    
    //MARK: ServiceCall
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_MY_ORDERS_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    // Parse and sort orders
                    var orders = (response.value(forKey: KKey.payload) as? NSArray ?? []).map { obj in
                        return MyOrderModel(dict: obj as? NSDictionary ?? [:])
                    }
                    
                    // Sort in reverse order by ID to show newest first
                    orders.sort { $0.id > $1.id }
                    self.listArr = orders
                    
                } else {
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

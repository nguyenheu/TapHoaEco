//
//  ExploreViewModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 01/05/2024.
//

import Foundation
class ExploreViewModel: ObservableObject
{
    static var shared: ExploreViewModel = ExploreViewModel()
    
    @Published var txtSearch: String = "" {
        didSet {
            filterList()
        }
    }
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var listArr: [ExploreCategoryModel] = []
    @Published var filteredList: [ExploreCategoryModel] = []
    
    init() {
        serviceCallList()
    }

    func filterList() {
        if txtSearch.isEmpty {
            filteredList = listArr
        } else {
            filteredList = listArr.filter { category in
                category.name.lowercased().contains(txtSearch.lowercased())
            }
        }
    }
    
    //MARK: ServiceCall
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_EXPLORE_LIST, isToken: true ) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        
                        return ExploreCategoryModel(dict: obj as? NSDictionary ?? [:])
                    })
                    
                    self.filteredList = self.listArr
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

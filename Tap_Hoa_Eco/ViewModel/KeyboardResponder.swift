//
//  KeyboardResponder.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 20/5/24.
//

//import SwiftUI
//import Combine
//
//class KeyboardResponder: ObservableObject {
//    @Published var isKeyboardVisible: Bool = false
//    
//    private var cancellables: Set<AnyCancellable> = []
//    
//    init() {
//        let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//            .map { _ in true }
//        
//        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
//            .map { _ in false }
//        
//        Publishers.Merge(keyboardWillShow, keyboardWillHide)
//            .assign(to: \.isKeyboardVisible, on: self)
//            .store(in: &cancellables)
//    }
//}

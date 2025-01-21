//
//  AccountItem.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 20/5/24.
//

import SwiftUI
enum AccountItem: Hashable {
    case order, idCard, location, paymentCard, promoCode, bell
    
    var iconName: String {
        switch self {
        case .order: return "ic_order"
        case .idCard: return "ic_id_card"
        case .location: return "ic_location"
        case .paymentCard: return "ic_payment_card"
        case .promoCode: return "ic_promo_code"
        case .bell: return "ic_bell"
        }
    }
    
    var title: String {
        switch self {
        case .order: return DataConstants.Account.orders.localized
        case .idCard: return DataConstants.Account.details.localized
        case .location: return DataConstants.Account.deliveryAddress.localized
        case .paymentCard: return DataConstants.Account.paymentMethods.localized
        case .promoCode: return DataConstants.Account.promoCodes.localized
        case .bell: return DataConstants.Account.notifications.localized
        }
    }
}

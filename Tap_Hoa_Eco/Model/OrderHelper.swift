//
//  OrderHelper.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 19/5/24.
//

import Foundation
import SwiftUI

class OrderHelper {
    static func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1: return DataConstants.OrderStatus.placed.localized
        case 2: return DataConstants.OrderStatus.accepted.localized
        case 3: return DataConstants.OrderStatus.delivered.localized
        case 4: return DataConstants.OrderStatus.cancelled.localized
        case 5: return DataConstants.OrderStatus.rejected.localized
        default: return ""
        }
    }
    
    static func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1: return DataConstants.OrderStatus.delivery.localized
        case 2: return DataConstants.OrderStatus.pickup.localized
        default: return ""
        }
    }
    
    static func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1: return DataConstants.OrderStatus.cashPayment.localized
        case 2: return DataConstants.OrderStatus.cardPayment.localized
        default: return ""
        }
    }
    
    static func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1: return DataConstants.OrderStatus.processing.localized
        case 2: return DataConstants.OrderStatus.success.localized
        case 3: return DataConstants.OrderStatus.error.localized
        case 4: return DataConstants.OrderStatus.refunded.localized
        default: return ""
        }
    }
    
    // Color helper methods remain the same
    static func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        if mObj.paymentType == 1 {
            return Color.orange
        }
        
        switch mObj.paymentStatus {
        case 1: return Color.blue
        case 2: return Color.green
        case 3: return Color.red
        case 4: return Color.green
        default: return Color.white
        }
    }
    
    static func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        switch mObj.orderStatus {
        case 1: return Color.blue
        case 2: return Color.green
        case 3: return Color.green
        case 4: return Color.red
        case 5: return Color.red
        default: return Color.primary
        }
    }
}

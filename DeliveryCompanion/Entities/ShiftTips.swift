//
//  ShiftTips.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class ShiftTips {
    var amount: Decimal = 0
    var tiptype: TipType?
    var service: Service?
    
    enum TipType: String, Codable {
        case cash
        case card
    }
    
    init(amount: Decimal, tiptype: TipType? = nil, service: Service? = nil) {
        self.amount = amount
        self.tiptype = tiptype
        self.service = service
    }
}

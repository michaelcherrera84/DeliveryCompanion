//
//  Tip.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import Foundation
import SwiftData

@Model
class Tip {
    var amount: Decimal = 0
    var type: TipType?
    var delivery: Delivery?
    
    enum TipType: String, CaseIterable, Codable, Identifiable {
        case cash, card, other
        var id: String { self.rawValue }
    }
    
    init(amount: Decimal, type: TipType? = nil, delivery: Delivery? = nil) {
        self.amount = amount
        self.type = type
        self.delivery = delivery
    }
}

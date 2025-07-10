//
//  Tip.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import Foundation
import SwiftData

@Model
class Tip: Identifiable {
    var id: UUID = UUID()
    var delivery: Delivery?
    var amount: Decimal = 0
    var type: TipType?
    
    enum TipType: String, CaseIterable, Codable, Identifiable {
        case cash, card, other
        var id: String { self.rawValue }
    }
    
    init(delivery: Delivery? = nil, amount: Decimal, type: TipType? = nil) {
        self.delivery = delivery
        self.amount = amount
        self.type = type
    }
}

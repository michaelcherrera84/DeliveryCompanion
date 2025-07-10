//
//  ServicePayment.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class ServicePayment {
    var delivery: Delivery?
    var amount: Decimal = 0
    var service: Service?
    
    init(delivery: Delivery? = nil, amount: Decimal, service: Service? = nil) {
        self.delivery = delivery
        self.amount = amount
        self.service = service
    }
}

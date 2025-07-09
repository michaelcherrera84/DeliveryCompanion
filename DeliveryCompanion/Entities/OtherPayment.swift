//
//  OtherPayment.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class OtherPayment {
    var amount: Decimal = 0
    var service: Service?
    
    init(amount: Decimal, service: Service? = nil) {
        self.amount = amount
        self.service = service
    }
}

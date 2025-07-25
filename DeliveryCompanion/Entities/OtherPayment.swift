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
    var shift: Shift?
    var amount: Decimal = 0
    var service: Service?
    
    init(shift: Shift? = nil, amount: Decimal, service: Service? = nil) {
        self.shift = shift
        self.amount = amount
        self.service = service
    }
}

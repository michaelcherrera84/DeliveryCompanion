//
//  ShiftServicePayment.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/9/25.
//

import Foundation
import SwiftData

@Model
class ShiftServicePayment {
    var shift: Shift?
    var amount: Decimal = 0
    var service: Service?
    
    init(shift: Shift? = nil, amount: Decimal, service: Service? = nil) {
        self.shift = shift
        self.amount = amount
        self.service = service
    }
}

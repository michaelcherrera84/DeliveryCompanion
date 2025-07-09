//
//  Deduction.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class Deduction {
    var amount: Decimal = 0
    var deductionType: DeductionType?
    var service: Service?
    var notes: String?
    
    init(amount: Decimal, deductionType: DeductionType? = nil, service: Service? = nil, notes: String? = nil) {
        self.amount = amount
        self.deductionType = deductionType
        self.service = service
        self.notes = notes
    }
}

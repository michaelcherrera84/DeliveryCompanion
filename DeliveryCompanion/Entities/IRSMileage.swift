//
//  IRSMileage.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class IRSMileage {
    var date: Date = Date()
    var mileage: Decimal = 0
    
    init(date: Date, mileage: Decimal) {
        self.date = date
        self.mileage = mileage
    }
}

//
//  AnnualOdometer.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class AnnualOdometer {
    var date: Date = Date()
    var odometer: Double = 0
    
    init(date: Date, odometer: Double) {
        self.date = date
        self.odometer = odometer
    }
}

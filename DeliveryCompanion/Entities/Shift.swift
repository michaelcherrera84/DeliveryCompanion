//
//  Shift.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class Shift {
    var date: Date = Date()
    var servicePayments: [ServicePayment] = []
    var tips: [ShiftTips] = []
    var otherPayments: [OtherPayment] = []
    var deductions: [Deduction] = []
    var miles: Double?
    var mpg: Double?
    var gasCost: Decimal?
    var hours: Double?
    
    init(date: Date, servicePayments: [ServicePayment], tips: [ShiftTips], otherPayments: [OtherPayment], deductions: [Deduction], miles: Double? = nil, mpg: Double? = nil, gasCost: Decimal? = nil, hours: Double? = nil) {
        self.date = date
        self.servicePayments = servicePayments
        self.tips = tips
        self.otherPayments = otherPayments
        self.deductions = deductions
        self.miles = miles
        self.mpg = mpg
        self.gasCost = gasCost
        self.hours = hours
    }
}

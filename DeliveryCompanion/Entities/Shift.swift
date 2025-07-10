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
    var shiftServicePayments: [ShiftServicePayment]? = [ShiftServicePayment]()
    var tips: [ShiftTips]? = [ShiftTips]()
    var otherPayments: [OtherPayment]? = [OtherPayment]()
    var deductions: [Deduction]? = [Deduction]()
    var miles: Double = 0.0
    var mpg: Double = 0.0
    var gasCost: Decimal = 0.0
    var hours: Double = 0.0
    
    init(date: Date, shiftServicePayments: [ShiftServicePayment]? = nil, tips: [ShiftTips]? = nil, otherPayments: [OtherPayment]? = nil, deductions: [Deduction]? = nil, miles: Double, mpg: Double, gasCost: Decimal, hours: Double) {
        self.date = date
        self.shiftServicePayments = shiftServicePayments
        self.tips = tips
        self.otherPayments = otherPayments
        self.deductions = deductions
        self.miles = miles
        self.mpg = mpg
        self.gasCost = gasCost
        self.hours = hours
    }
}

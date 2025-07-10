//
//  Delivery.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import Foundation
import SwiftData

@Model
class Delivery {
    var date: Date = Date()
    var service: Service?
    var servicePayment: ServicePayment?
    var tips: [Tip] = []
    var address: Address?
    var notes: String = ""
    
    init(date: Date, service: Service? = nil, servicePayment: ServicePayment? = nil, tips: [Tip], address: Address? = nil, notes: String) {
        self.date = date
        self.service = service
        self.servicePayment = servicePayment
        self.tips = tips
        self.address = address
        self.notes = notes
    }
}

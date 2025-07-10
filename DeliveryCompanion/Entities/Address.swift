//
//  Address.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import Foundation
import SwiftData

@Model
class Address {
    var deliveries: [Delivery]? = [Delivery]()
    var neighborhood: String = ""
    var num: String = ""
    var street1: String = ""
    var street2: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    init(deliveries: [Delivery]? = nil, neighborhood: String, num: String, street1: String, street2: String, city: String, state: String, zip: String, latitude: Double, longitude: Double) {
        self.deliveries = deliveries
        self.neighborhood = neighborhood
        self.num = num
        self.street1 = street1
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Address {
    var fullAddress: String {
        [
            num,
            street1,
            street2,
            city,
            state,
            zip
        ]
        .compactMap { $0 }
        .joined(separator: " ")
    }
}

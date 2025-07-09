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
    var num: String?
    var street1: String?
    var street2: String?
    var city: String?
    var state: String?
    var zip: String?
    var latitude: Double?
    var longitude: Double?
    
    init(num: String? = nil, street1: String? = nil, street2: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil, latitude: Double? = nil, longitude: Double? = nil) {
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

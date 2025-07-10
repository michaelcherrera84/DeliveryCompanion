//
//  Service.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import Foundation
import SwiftData

@Model
class Service {
    var name: String = ""
    @Attribute(.externalStorage) var logo: Data?
    var phoneNumber: String = ""
    var email: String = ""
    
    init(name: String, logo: Data? = nil, phoneNumber: String, email: String) {
        self.name = name
        self.logo = logo
        self.phoneNumber = phoneNumber
        self.email = email
    }
}

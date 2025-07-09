//
//  DeductionType.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import SwiftData

@Model
class DeductionType {
    var type: String = ""
    
    init(type: String) {
        self.type = type
    }
}

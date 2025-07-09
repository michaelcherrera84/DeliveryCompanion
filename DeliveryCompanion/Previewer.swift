//
//  Previewer.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import Foundation
import PhotosUI
import SwiftData

@MainActor
struct Previewer {
    let modelContainer: ModelContainer
    
    //    let address: Address
    //    let annualOdometer: AnnualOdometer
    //    let deduction: Deduction
    //    let deductionType: DeductionType
    //    let delivery: Delivery
    //    let irsMileage: IRSMileage
    //    let OtherPayment: OtherPayment
    let service: Service
    let servicePayment: ServicePayment
    //    let shift: Shift
    //    let shiftTips: ShiftTips
    //    let tip: Tip

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        modelContainer = try ModelContainer(
            for: ServicePayment.self,
            configurations: config
        )

        service = Service(
            name: "DoorDash",
            logo: UIImage(named: "DoorDashLogo")?.pngData(),
            phoneNumber: "1 (855) 222-8111",
            email: "drive-support@doordash.com"
        )

        servicePayment = ServicePayment(amount: Decimal(string: "7.59")!, service: service)

        modelContainer.mainContext.insert(servicePayment)
    }
}

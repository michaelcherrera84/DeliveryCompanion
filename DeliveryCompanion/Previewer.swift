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

    let address: Address
    let delivery: Delivery
    let service: Service
    let servicePayment: ServicePayment
    let tip: Tip

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        modelContainer = try ModelContainer(
            for: Address.self,
            Delivery.self,
            Service.self,
            ServicePayment.self,
            Tip.self,
            configurations: config
        )

        let service = Service(
            name: "DoorDash",
            logo: UIImage(named: "DoorDashLogo")?.pngData(),
            phoneNumber: "1 (855) 222-8111",
            email: "drive-support@doordash.com"
        )

        let servicePayment = ServicePayment(
            amount: Decimal(string: "7.59")!,
            service: service
        )

        let address = Address(
            deliveries: [],
            neighborhood: "River Ranch",
            num: "123",
            street1: "Main St",
            street2: "Apt 4",
            city: "Lafayette",
            state: "LA",
            zip: "70501",
            latitude: 0.0,
            longitude: 0.0
        )

        let delivery = Delivery(
            date: Date(),
            service: service,
            servicePayment: servicePayment,
            tips: [],
            address: address,
            notes: ""
        )

        let tip = Tip(
            delivery: delivery,
            amount: Decimal(string: "0.00")!,
            type: Tip.TipType.card
        )

        delivery.tips = [tip]
        address.deliveries = [delivery]

        modelContainer.mainContext.insert(servicePayment)
        modelContainer.mainContext.insert(address)

        self.service = service
        self.servicePayment = servicePayment
        self.address = address
        self.delivery = delivery
        self.tip = tip
    }
}

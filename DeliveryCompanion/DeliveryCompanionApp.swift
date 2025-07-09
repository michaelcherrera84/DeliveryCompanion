//
//  DeliveryCompanionApp.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import SwiftUI
import SwiftData

@main
struct DeliveryCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Service.self, Delivery.self])
    }
}

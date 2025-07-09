//
//  AddDelivery.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import SwiftData
import SwiftUI

struct AddDelivery: View {
    @Environment(\.modelContext) var modelContext
    @Binding var navigationPath: NavigationPath
    @State private var date: Date = Date()
    @State private var service: Service?
    @State private var servicePayment: ServicePayment?
    @State private var tips: [Tip] = []
    @State private var address: Address?
    @State private var notes: String?

    var body: some View {
        Form {
            Section {
                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
            
            ServiceSection(service: $service, servicePayment: $servicePayment)
            
            TipsSection(tips: $tips)
        }
        .navigationTitle("Add Delivery")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return AddDelivery(navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

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
    @Bindable var delivery: Delivery

    var body: some View {
        Form {
            Section {
                DatePicker(
                    "Date",
                    selection: $delivery.date,
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
            
            ServiceSection(delivery: delivery)

            TipsSection(delivery: delivery)

            Section {
                Button("Add an Address", action: addAddress)
            }
            
            Section("Notes") {
                TextField("", text: $delivery.notes, axis: .vertical)
                    .frame(minHeight: 100, alignment: .top)
            }
        }
        .navigationTitle("Add Delivery")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Address.self) { address in
            AddAddress(address: address)
        }
    }

    func addAddress() {
        let address = Address(
            deliveries: [],
            neighborhood: "",
            num: "",
            street1: "",
            street2: "",
            city: "",
            state: "",
            zip: "",
            latitude: 0.0,
            longitude: 0.0
        )
        modelContext.insert(address)
        delivery.address = address
        navigationPath.append(address)
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return AddDelivery(
            navigationPath: .constant(NavigationPath()),
            delivery: previewer.delivery
        )
        .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

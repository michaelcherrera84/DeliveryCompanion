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
            AddAddress(address: address, delivery: .constant(delivery))
        }
    }

    /// Creates a temporary `Address` instance for user input and navigates to the address form view.
    ///
    /// This function is typically called when the user taps "Add Address." It prepares an empty
    /// `Address` object, without persisting it, and pushes it onto the navigation stack.
    /// The address is filled out by the user in the destination view, and later validated or saved.
    ///
    /// Note: The address is not inserted into the `ModelContext` at this point —
    /// it remains in-memory until explicitly saved later.
    func addAddress() {

        // Create a new in-memory Address instance with empty/default values
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

        // Push the new Address object onto the navigation stack
        // The view associated with Address.self will render next
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

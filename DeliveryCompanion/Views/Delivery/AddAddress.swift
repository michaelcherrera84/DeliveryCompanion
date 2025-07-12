//
//  AddAddress.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/9/25.
//

import MapKit
import SwiftUI

struct AddAddress: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var address: Address
    @Binding var delivery: Delivery
    @State private var coordinate: CLLocationCoordinate2D?

    struct LocationPin: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    var body: some View {
        Form {
            Section("Delivery Address") {
                TextField("Street Number", text: $address.num)
                TextField("Street Name", text: $address.street1)
                TextField("Apt/Suite", text: $address.street2)
                TextField("City", text: $address.city)
                TextField("State", text: $address.state)
                TextField("Zip Code", text: $address.zip)
                TextField("Neighborhood", text: $address.neighborhood)
            }

            Section("Location") {
                Button("Show on Map") {
                    geocodeAddress()
                }

                if let coordinate {
                    let region = MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.01,
                            longitudeDelta: 0.01
                        )
                    )

                    let pin = LocationPin(coordinate: coordinate)

                    Map(initialPosition: .region(region)) {
                        Marker("Delivery", coordinate: pin.coordinate)
                    }
                    .frame(height: 200)
                    .listRowInsets(EdgeInsets())
                }

            }
        }
        .navigationTitle("Add Address")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveAddress()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    /// Attempts to geocode the current address and update its coordinates.
    ///
    /// This function uses `CLGeocoder` to convert the human-readable address
    /// stored in `address.fullAddress` into a geographic coordinate. If successful,
    /// it updates both the internal state (`coordinate`) and the `Address` model
    /// with the resolved latitude and longitude.
    private func geocodeAddress() {

        // Create an instance of Apple's geocoding service
        let geocoder = CLGeocoder()

        // Attempt to convert the address string into location data
        geocoder.geocodeAddressString(address.fullAddress) {
            placemarks,
            error in

            // If at least one valid placemark is returned, extract its location
            if let location = placemarks?.first?.location {
                let coord = location.coordinate

                // Update the internal @State coordinate for display on the map
                coordinate = coord

                // Persist the coordinate in the Address model for later use
                address.latitude = coord.latitude
                address.longitude = coord.longitude
            }

            // Todo: If geocoding fails, nothing happens here —
            // Add error handling or user feedback.
        }
    }

    /// Persists the current address by checking for an existing match in the model context.
    ///
    /// If an existing address is found that matches the user-provided fields (street, city, etc.),
    /// it reuses that address and associates it with the current delivery.
    /// If no match is found, the address is treated as new and inserted into the model context.
    /// In both cases, the delivery is linked to the address, and vice versa.
    private func saveAddress() {

        // Attempt to find an existing address in the model context that matches the input
        if let existingAddress = Address.findExistingAddress(
            num: address.num,
            street1: address.street1,
            street2: address.street2,
            city: address.city,
            state: address.state,
            zip: address.zip,
            in: modelContext
        ) {
            // If a match is found, associate the current delivery with the existing address
            existingAddress.deliveries?.append(delivery)
            delivery.address = existingAddress
        } else {
            // If no match is found, treat this as a new address
            // Associate the delivery with this new address
            address.deliveries?.append(delivery)
            delivery.address = address
            
            // Persist the new address into the SwiftData model context
            modelContext.insert(address)
        }

        // Dismiss the current view (typically returns to the previous screen)
        dismiss()
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return AddAddress(
            address: previewer.address,
            delivery: .constant(previewer.delivery)
        )
        .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

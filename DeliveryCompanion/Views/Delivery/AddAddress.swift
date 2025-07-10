//
//  AddAddress.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/9/25.
//

import MapKit
import SwiftUI

struct AddAddress: View {
    @Bindable var address: Address
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
    }
    

    private func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address.fullAddress) { placemarks, error in
            if let location = placemarks?.first?.location {
                let coord = location.coordinate
                coordinate = coord

                address.latitude = coord.latitude
                address.longitude = coord.longitude
            }
        }
    }
}


#Preview {
    do {
        let previewer = try Previewer()

        return AddAddress(
            address: previewer.address
        )
        .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

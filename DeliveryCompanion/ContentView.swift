//
//  ContentView.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @Query var services: [Service]
    @Query var deliveries: [Delivery]
    @Query var addresses: [Address]

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                VStack {

                    ForEach(services) { service in
                        Text(service.name)
                            .padding()
                    }

                    Button(
                        "Add Service",
                        systemImage: "plus",
                        action: addService
                    )
                    .navigationDestination(for: Service.self) { service in
                        AddEditService(navigationPath: $path, service: service)
                    }

                    ForEach(deliveries) { delivery in
                        HStack {
                            Text(
                                String(
                                    describing: delivery.servicePayment?.amount
                                )
                            )
                            Text(delivery.address?.num ?? "")
                        }
                    }

                    Button(
                        "Add Delivery",
                        systemImage: "plus",
                        action: addDelivery
                    )
                    .navigationDestination(for: Delivery.self) { delivery in
                        AddDelivery(navigationPath: $path, delivery: delivery)
                    }
                    
                    ForEach(addresses) { address in
                        Text(address.num)
                    }
                }
            }
        }
    }

    func addService() {
        let service = Service(name: "", phoneNumber: "", email: "")
        modelContext.insert(service)
        path.append(service)
    }

    func addDelivery() {
        let tips: [Tip] = []
        let delivery = Delivery(date: Date(), tips: tips, notes: "")
        modelContext.insert(delivery)
        path.append(delivery)
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return ContentView()
            .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

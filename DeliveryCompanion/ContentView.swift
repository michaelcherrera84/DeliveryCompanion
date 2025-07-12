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
                List {
                    Label("Services", systemImage: "list.bullet")
                    ForEach(services) { service in
                        NavigationLink(value: service) {
                            Text(service.name)
                        }
                    }

                    Button(
                        "Add Service",
                        systemImage: "plus",
                        action: addService
                    )
                }
                .navigationDestination(for: Service.self) { service in
                    AddEditService(navigationPath: $path, service: service)
                }

                List {
                    Label("Deliveries", systemImage: "list.bullet")
                    ForEach(deliveries) { delivery in
                        HStack {
                            if let amount = delivery.servicePayment?.amount {
                                Text(
                                    "Payment: $\(String(describing: amount))"
                                )
                            }
                            if let num = delivery.address?.num,
                                let address = delivery.address?.street1
                            {
                                Text("Address: \(num)")
                                Text(address)
                            }
                        }
                    }

                    Button(
                        "Add Delivery",
                        systemImage: "plus",
                        action: addDelivery
                    )
                }
                .navigationDestination(for: Delivery.self) { delivery in
                    AddDelivery(navigationPath: $path, delivery: delivery)
                }

                List {
                    Label("Addresses", systemImage: "list.bullet")
                    ForEach(addresses) { address in
                        HStack {
                            Text(address.num)
                            Text(address.street1)
                            Text(address.city)
                            Text(address.state)
                            Text(address.zip)
                            Text("\(address.deliveries?.count ?? 0)")
                            Text("\(addresses.count)")
                        }
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

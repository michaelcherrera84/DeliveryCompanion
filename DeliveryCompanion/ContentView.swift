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

    var body: some View {
        NavigationStack(path: $path) {
            VStack {

                List {
                    ForEach(services) { service in
                        Text(service.name)
                    }
                }

                Button("Add Service", systemImage: "plus", action: addService)
                    .navigationDestination(for: Service.self) { service in
                        AddEditService(navigationPath: $path, service: service)
                    }

                Button("Add Delivery", systemImage: "plus", action: addDelivery)
                    .navigationDestination(for: Delivery.self) { Delivery in
                        AddDelivery(navigationPath: $path)
                    }
            }
        }
    }

    func addService() {
        let service = Service(name: "")
        modelContext.insert(service)
        path.append(service)
    }

    func addDelivery() {
        let tips: [Tip] = []
        let delivery = Delivery(date: Date(), tips: tips)
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

//
//  ServiceSection.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import SwiftData
import SwiftUI

struct ServiceSection: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var service: Service?
    @Binding var servicePayment: ServicePayment?
    @State private var paymentString: String = ""
    @State private var isInvalidInput: Bool = false

    @Query var services: [Service]

    var body: some View {
        Section("Service") {
            Picker("Select a service", selection: $service) {
                Text("")
                    .tag(Optional<Service>.none)

                if services.isEmpty == false {
                    ForEach(services) { item in
                        Text(item.name)
                            .tag(Optional(item))
                    }
                }
            }

            HStack {
                Label("Service payment", systemImage: "")
                    .labelStyle(.titleOnly)

                Spacer()

                CurrencyInput(
                    amount: Binding(
                        get: { servicePayment?.amount ?? 0.00 },
                        set: { newAmount in
                            if servicePayment == nil {
                                servicePayment = ServicePayment(amount: newAmount)
                            } else {
                                servicePayment?.amount = newAmount
                            }
                        }
                    )
                )
                .multilineTextAlignment(.trailing)
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return Form {
            ServiceSection(
                service: .constant(previewer.service),
                servicePayment: .constant(previewer.servicePayment)
            )
        }
        .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

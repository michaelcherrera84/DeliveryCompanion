//
//  TipsSection.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import SwiftUI

struct TipsSection: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var delivery: Delivery
    
    var body: some View {
        Section("Tips") {
            ForEach($delivery.tips) { tip in
                HStack {
                    CurrencyInput(amount: tip.amount)
                    
                    Picker("Type", selection: tip.type) {
                        ForEach(Tip.TipType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                }
            }
            Button("Add Tip", action: addTip)
        }
    }
    
    func addTip() {
        delivery.tips.append(Tip(amount: 0.0))
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return Form {
            TipsSection(
                delivery: previewer.delivery
            )
        }
        .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

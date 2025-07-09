//
//  TipsSection.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import SwiftUI

struct TipsSection: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var tips: [Tip]
    
    var body: some View {
        Section("Tips") {
            ForEach($tips) { $tip in
                HStack {
                    CurrencyInput(amount: $tip.amount)
                    
                    Picker("Type", selection: $tip.type) {
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
        tips.append(Tip(amount: 0.0))
    }
}

#Preview {
    let tips: [Tip] = []
    TipsSection(tips: .constant(tips))
}

//
//  CurrencyInput.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/8/25.
//

import SwiftUI

struct CurrencyInput: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var amount: Decimal
    @State private var amountString: String = ""
    @State private var isInvalidInput: Bool = false

    var body: some View {
        TextField("$0.00", text: $amountString)
            .keyboardType(.decimalPad)
            .onChange(of: amountString) { oldValue, newValue in
                let filtered = newValue.filter {
                    "0123456789.-".contains($0)
                }
                if let decimal = Decimal(string: filtered),
                    !filtered.isEmpty
                {
                    amount = decimal
                    isInvalidInput = false
                } else {
                    amount = 0.0
                    isInvalidInput = !filtered.isEmpty
                }

                amountString = "$" + filtered
            }
    }
}

#Preview {
    CurrencyInput(amount: .constant(123.45))
}

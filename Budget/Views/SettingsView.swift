import SwiftUI

struct SettingsView: View {

    @AppStorage("monthlyBudget")
    private var monthlyBudget: Double = 0

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var currencyFormatter: NumberFormatter = .currencyFormatter

    var body: some View {
        NavigationStack {
            Form {
                Section("Monthly Budget") {
                    TextField("Monthly Budget", value: $monthlyBudget, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                }
            }
            .closeTopBarButton()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

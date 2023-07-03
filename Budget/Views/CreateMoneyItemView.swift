import SwiftData
import SwiftUI

struct CreateMoneyItemView: View {

    @Environment(\.dismiss)
    private var dismiss
    @Environment(\.modelContext)
    private var modelContext

    @State
    private var amount: Double = 0
    @State
    private var currencyFormatter: NumberFormatter = .currencyFormatter
    @State
    private var frequency: MoneyItem.Frequency = .monthly
    @State
    private var notes: String = ""
    @State
    private var title: String = ""

    let moneyCategory: MoneyCategory

    private func createMoneyItem() {
        withAnimation {
            let _notes: String? = notes.isEmpty ? nil : notes
            let newMoneyItem = MoneyItem(amount: amount, frequency: frequency, notes: _notes, title: title)
            moneyCategory.items.append(newMoneyItem)
        }
    }

    var body: some View {
        NavigationStack {
            Form {

                Section {

                    TextField("Title", text: $title, prompt: Text("Title"))
                    TextField("Notes", text: $notes, axis: .vertical)
                }

                Section {
                    TextField("Amount", value: $amount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)

                    Picker(selection: $frequency) {
                        ForEach(MoneyItem.Frequency.allCases, id: \.rawValue) { frequency in
                            Text(frequency.rawValue)
                                .tag(frequency)
                        }
                    } label: {
                        Text("Frequency")
                    }
                }

                Section {
                    Button {
                        createMoneyItem()
                        dismiss()
                    } label: {
                        Text("Create")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .closeTopBarButton()
            .navigationTitle("Create Money Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

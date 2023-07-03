import SwiftData
import SwiftUI

struct MoneyCategoryOverviewView: View {

    enum ItemSectionType {
        case combined
        case split
    }

    @AppStorage("monthlyBudget")
    private var monthlyBudget: Double = 0

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var isPresentingCreateMoneyItem: Bool = false
    @State
    private var itemSectionType: ItemSectionType = .split

    let moneyCategory: MoneyCategory

    private func delete(moneyItem: MoneyItem) {
        modelContext.delete(moneyItem)
    }

    @ViewBuilder
    private var summarySection: some View {
        Section("Summary") {

            SplitText {
                Text("Total")
            } trailing: {
                Text(moneyCategory.monthlyTotal, format: .currency(code: "USD"))
            }

            SplitText {
                Text("Percentage")
            } trailing: {
                if monthlyBudget > 0 {
                    Text(moneyCategory.monthlyTotal / monthlyBudget, format: .percent.precision(.fractionLength(..<3)))
                } else {
                    Text("--")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    @ViewBuilder
    private var itemsSection: some View {
        Section("Items") {
            if moneyCategory.items.isEmpty {
                Text("No Items")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(moneyCategory.items.sorted(using: \.title)) { moneyItem in
                    SplitText {
                        VStack(alignment: .leading) {

                            Text(moneyItem.title)
                                .lineLimit(1)

                            Text(moneyItem.frequency.rawValue)
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                    } trailing: {
                        Text(moneyItem.amount, format: .currency(code: "USD"))
                    }
                    .swipeActions {
                        Button {
                            delete(moneyItem: moneyItem)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var monthlyYearlySections: some View {

        let monthlyItems = moneyCategory.items.filter { $0.frequency == .monthly }
        let yearlyItems = moneyCategory.items.filter { $0.frequency == .yearly }

        Section("Monthly") {
            if monthlyItems.isEmpty {
                Text("No Items")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(monthlyItems.sorted(using: \.title)) { moneyItem in
                    SplitText {
                        Text(moneyItem.title)
                    } trailing: {
                        Text(moneyItem.amount, format: .currency(code: "USD"))
                    }
                    .swipeActions {
                        Button {
                            delete(moneyItem: moneyItem)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
        }

        Section("Yearly") {
            if yearlyItems.isEmpty {
                Text("No Items")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(yearlyItems.sorted(using: \.title)) { moneyItem in
                    SplitText {
                        Text(moneyItem.title)
                    } trailing: {
                        Text(moneyItem.amount, format: .currency(code: "USD"))
                    }
                    .swipeActions {
                        Button {
                            delete(moneyItem: moneyItem)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                }
            }
        }
    }

    var body: some View {
        List {

            summarySection

            Button {
                isPresentingCreateMoneyItem = true
            } label: {
                Text("Create Item")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.blue)

            switch itemSectionType {
            case .combined:
                itemsSection
            case .split:
                monthlyYearlySections
            }
        }
        .navigationTitle(moneyCategory.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresentingCreateMoneyItem) {
            CreateMoneyItemView(moneyCategory: moneyCategory)
                .closeTopBarButton()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        itemSectionType = .combined
                    } label: {
                        if itemSectionType == .combined {
                            Label("Combined", systemImage: "checkmark.circle")
                        } else {
                            Text("Combined")
                        }
                    }

                    Button {
                        itemSectionType = .split
                    } label: {
                        if itemSectionType == .split {
                            Label("Split", systemImage: "checkmark.circle")
                        } else {
                            Text("Split")
                        }
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
}

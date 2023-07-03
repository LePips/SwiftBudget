import Charts
import SwiftData
import SwiftUI

struct HomeView: View {

    @AppStorage("monthlyBudget")
    private var monthlyBudget: Double = 0

    @Query
    private var moneyCategories: [MoneyCategory]

    @State
    private var isPresentingCreateCategory: Bool = false
    @State
    private var isPresentingSettings: Bool = false
    @State
    private var selectedData: Int?

    @ViewBuilder
    private var summarySection: some View {

        let monthlyTotal = moneyCategories.map(\.monthlyTotal).reduce(0, +)

        Section {
            SplitText {
                Text("Budget")
            } trailing: {
                Text(monthlyBudget, format: .usdCurrency())
            }

            SplitText {
                Text("Spending")
            } trailing: {
                Text(monthlyTotal, format: .usdCurrency())
            }

            if monthlyBudget > 0 {
                SplitText {
                    Text("Left")
                } trailing: {
                    Text(monthlyBudget - monthlyTotal, format: .usdCurrency())
                }

                SplitText {
                    HStack {
                        if monthlyTotal > monthlyBudget {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }

                        Text("Percentage")
                    }
                } trailing: {
                    PercentRoundedText(monthlyBudget / monthlyTotal)
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    Section {
                        Chart(moneyCategories.sorted(using: \.title)) { spendingCategory in
                            SectorMark(
                                angle: .value("Total", spendingCategory.monthlyTotal),
                                innerRadius: .ratio(0.7),
                                angularInset: 1
                            )
                            .cornerRadius(5)
                            .foregroundStyle(spendingCategory.color.color)
                        }
                        .chartLegend(.hidden)
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                    }
                    .frame(height: proxy.size.height * 0.3)

                    summarySection

                    ForEach(moneyCategories.sorted(using: \.title)) { moneyCategory in
                        NavigationLink {
                            MoneyCategoryOverviewView(moneyCategory: moneyCategory)
                        } label: {
                            HStack {

                                RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                                    .frame(width: 10)
                                    .foregroundStyle(moneyCategory.color.color)

                                Text(moneyCategory.title)

                                Spacer()

                                Text(moneyCategory.monthlyTotal, format: .usdCurrency())
                            }
                        }
                    }

                    Section {
                        Button(action: {
                            isPresentingCreateCategory = true
                        }, label: {
                            Text("Create")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        })
                        .listRowBackground(Color.blue)
                    }
                }
                .navigationTitle("Budget")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isPresentingCreateCategory) {
                    CreateMoneyCategoryView()
                        .closeTopBarButton()
                }
                .sheet(isPresented: $isPresentingSettings) {
                    SettingsView()
                        .closeTopBarButton()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresentingSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                }
            }
        }
    }
}

actor ContentViewPreviewSampleData {

    @MainActor
    static var container: ModelContainer = {
        let schema = Schema([MoneyCategory.self, MoneyItem.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])

        let sampleWantsTransactions: [MoneyItem] = [
            .init(amount: 29.99, frequency: .monthly, notes: nil, title: "Netflix"),
            .init(amount: 80, frequency: .monthly, notes: nil, title: "Momentum"),
            .init(amount: 100, frequency: .yearly, title: "Tesla Premium Connectivity"),
        ]

        let sampleWants = MoneyCategory(title: "Wants", color: .red)
        sampleWants.items = sampleWantsTransactions
        sampleWantsTransactions.forEach { moneyItem in
            moneyItem.category = sampleWants
        }

        let sampleNeedsTransactions: [MoneyItem] = [
            .init(amount: 518.00, frequency: .monthly, notes: nil, title: "Car Payment"),
        ]

        let sampleNeeds = MoneyCategory(title: "Needs", color: .green)
        sampleNeeds.items = sampleNeedsTransactions
        sampleNeedsTransactions.forEach { moneyItem in
            moneyItem.category = sampleNeeds
        }

        let sampleData: [any PersistentModel] = [
            sampleWants, sampleNeeds,
        ]
        sampleData.forEach {
            container.mainContext.insert($0)
        }
        return container
    }()
}

// @MainActor
// #Preview {
//    HomeView()
//        .modelContainer(ContentViewPreviewSampleData.container)
// }

//
//  ContentView.swift
//  Budget
//
//  Created by Ethan Pippin on 6/26/23.
//

import Charts
import SwiftData
import SwiftUI

struct HomeView: View {
    
    @Query
    private var spendingCategories: [MoneyCategory]
    
    @State
    private var isPresentingCreateCategory: Bool = false
    @State
    private var isPresentingSettings: Bool = false
    @State
    private var selectedData: Int?

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    Section {
                        Chart(spendingCategories) { spendingCategory in
                            SectorMark(
                                angle: .value("Amount", spendingCategory.transactionsAmount),
                                innerRadius: .ratio(0.7),
                                angularInset: 1
                            )
                            .cornerRadius(5)
                            .foregroundStyle(by: .value("Title", spendingCategory.title))
                        }
                        .chartLegend(.hidden)
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                    }
                    .frame(height: proxy.size.height * 0.3)
                    
                    Section("Categories") {
                        ForEach(spendingCategories) { spendingCategory in
                            Text(spendingCategory.title)
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
                    CreateSpendingCategoryView()
                }
                .sheet(isPresented: $isPresentingSettings) {
                    SettingsView()
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
        let schema = Schema([MoneyCategory.self, SpendingTransaction.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        
        let sampleWantsTransactions: [SpendingTransaction] = [
            .init(title: "Netflix", amount: 29.99),
            .init(title: "Momentum", amount: 80)
        ]
        
        let sampleWants = MoneyCategory(title: "Wants", type: .spending)
        sampleWants.transactions = sampleWantsTransactions
        
        let sampleNeedsTransactions: [SpendingTransaction] = [
            .init(title: "Car Payment", amount: 518.00)
        ]
        
        let sampleNeeds = MoneyCategory(title: "Needs", type: .spending)
        sampleNeeds.transactions = sampleNeedsTransactions
        
        let sampleData: [any PersistentModel] = [
            sampleWants, sampleNeeds
        ]
        sampleData.forEach {
            container.mainContext.insert($0)
        }
        return container
    }()
}

@MainActor
#Preview {
    HomeView()
        .modelContainer(ContentViewPreviewSampleData.container)
}

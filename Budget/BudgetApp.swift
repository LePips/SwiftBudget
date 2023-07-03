import SwiftUI

@main
struct BudgetApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [
            MoneyCategory.self,
        ])
    }
}

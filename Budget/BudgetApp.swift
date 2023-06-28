//
//  BudgetApp.swift
//  Budget
//
//  Created by Ethan Pippin on 6/26/23.
//

import SwiftUI

@main
struct BudgetApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(ContentViewPreviewSampleData.container)
//        .modelContainer(for: [
//            SpendingCategory.self
//        ])
    }
}

//
//  SpendingCategory.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftData

@Model
final class MoneyCategory {
    
    struct MoneyType: CaseIterable, Codable {
        
        let title: String
        
        private init(title: String) {
            self.title = title
        }
        
        static let income: MoneyType = MoneyType(title: "Income")
        static let spending: MoneyType = MoneyType(title: "Spending")
        
        static var allCases: [MoneyCategory.MoneyType] = [income, spending]
    }
    
    @Attribute(.unique)
    var title: String
    
    var type: MoneyType
    
    @Relationship(.cascade)
    var transactions: [SpendingTransaction]
    
    var transactionsAmount: Double {
        transactions.map(\.amount).reduce(0, +)
    }
    
    init(title: String, type: MoneyType) {
        self.title = title
        self.type = type
        self.transactions = []
    }
    
    func addTransaction(title: String, amount: Double) {
        
    }
}

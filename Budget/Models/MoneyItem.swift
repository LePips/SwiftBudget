//
//  SpendingTransaction.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import Foundation
import SwiftData

@Model
final class MoneyItem {
    
    enum Frequency: String, CaseIterable, Codable, RawRepresentable {
        case monthly = "Monthly"
        case yearly = "Yearly"
    }
    
    var category: MoneyCategory?
    
    var amount: Double
    var frequency: Frequency
    var notes: String?
    var title: String
    
    var monthlyAmount: Double {
        switch frequency {
        case .monthly:
            amount
        case .yearly:
            amount / 12
        }
    }
    
    init(amount: Double, frequency: Frequency, notes: String? = nil, title: String) {
        self.amount = amount
        self.frequency = frequency
        self.notes = notes
        self.title = title
    }
}

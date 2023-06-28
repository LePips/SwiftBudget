//
//  SpendingTransaction.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftData

@Model
final class SpendingTransaction {
    
    var title: String
    var amount: Double
    
    init(title: String, amount: Double) {
        self.title = title
        self.amount = amount
    }
}

//
//  SpendingCategory.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftData
import SwiftUI

@Model
final class MoneyCategory {
    
    @Attribute(.unique)
    var title: String
    
    var color: CodableColor
    
    @Relationship(.cascade, inverse: \MoneyItem.category)
    var items: [MoneyItem]
    
    var monthlyTotal: Double {
        items.map(\.amount).reduce(0, +)
    }
    
    init(title: String, color: Color) {
        self.title = title
        self.color = UIColor(color).codableColor
        self.items = []
    }
}

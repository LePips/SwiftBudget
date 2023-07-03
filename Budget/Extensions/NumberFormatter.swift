//
//  NumberFormatter.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import Foundation

extension NumberFormatter {
    
    static var currencyFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

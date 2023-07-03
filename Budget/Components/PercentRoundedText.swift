//
//  RoundedText.swift
//  Budget
//
//  Created by Ethan Pippin on 7/3/23.
//

import SwiftUI

struct PercentRoundedText: View {
    
    private let value: Double
    
    init(_ value: Double) {
        self.value = value
    }
    
    var body: some View {
        Text("\(value, specifier: "%.2f")%")
    }
}

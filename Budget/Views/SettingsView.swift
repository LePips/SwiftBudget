//
//  SettingsView.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("monthlyBudget")
    private var monthlyBudget: Double = 0
    
    @State
    private var currencyFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
     }()
    
    var body: some View {
        NavigationStack {
            Form {

                Section("Monthly Budget") {
                    TextField("Monthly Budget", value: $monthlyBudget, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

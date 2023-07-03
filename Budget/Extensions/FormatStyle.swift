//
//  FormatStyle.swift
//  Budget
//
//  Created by Ethan Pippin on 7/3/23.
//

import SwiftUI

extension FormatStyle {
    
    public static func usdCurrency<Value>() -> Self where Self == FloatingPointFormatStyle<Value>.Currency, Value : BinaryFloatingPoint {
        currency(code: "USD")
    }
}

import SwiftUI

public extension FormatStyle {

    static func usdCurrency<Value>() -> Self where Self == FloatingPointFormatStyle<Value>.Currency, Value: BinaryFloatingPoint {
        currency(code: "USD")
    }
}

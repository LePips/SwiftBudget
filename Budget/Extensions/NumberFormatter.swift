import Foundation

extension NumberFormatter {

    static var currencyFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

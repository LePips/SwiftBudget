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

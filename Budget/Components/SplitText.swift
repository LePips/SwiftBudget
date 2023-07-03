import SwiftUI

// TODO: Rename to HSpacerView
struct SplitText: View {

    let leading: () -> any View
    let trailing: () -> any View

    var body: some View {
        HStack {
            AnyView(leading())

            Spacer()

            AnyView(trailing())
        }
    }
}

import SwiftUI

struct CodableColor: Codable {

    var red: Double = 0.0
    var green: Double = 0.0
    var blue: Double = 0.0
    var alpha: Double = 0.0

    var color: Color {
        Color(uiColor: uiColor)
    }

    var uiColor: UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor: UIColor) {

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        self.red = r
        self.green = g
        self.blue = b
        self.alpha = a
    }
}

extension UIColor {

    var codableColor: CodableColor {
        CodableColor(uiColor: self)
    }
}

extension Color {

    init(codableColor: CodableColor) {
        self.init(uiColor: codableColor.uiColor)
    }
}

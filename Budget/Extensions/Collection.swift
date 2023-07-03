import Foundation

extension Collection {

    func sorted<Value: Comparable>(using keyPath: KeyPath<Element, Value>) -> [Element] {
        sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}

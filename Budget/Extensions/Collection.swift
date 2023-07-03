//
//  Collection.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import Foundation

extension Collection {
    
    func sorted<Value: Comparable>(using keyPath: KeyPath<Element, Value>) -> [Element] {
        sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}

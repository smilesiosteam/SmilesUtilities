//
//  ArrayExtension.swift
//  House
//
//  Created by Ahmed samir ali on 7/10/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation

public extension Array {
    func getFirstNElementsFromArray(_ number: Int) -> Array {
        return Array(self.prefix(number))
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    subscript (safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

public extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

//
//  OptionalExtension.swift
//  House
//
//  Created by Ahmed samir ali on 3/25/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation

public extension Swift.Optional where Wrapped == String {

    func asStringOrEmpty() -> String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }

    func asStringOrNilText() -> String {
        guard let unwrapped = self else {
            return "(nil)"
        }
        return unwrapped
    }
    
    func unwrap<T>(_ any: T) -> Any {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional, let first = mirror.children.first else {
            return any
        }
        return unwrap(first.value)
    }
    
}

public extension Swift.Optional where Wrapped == Int {
    
    func asIntOrEmpty() -> Int {
        guard let unwrapped = self else {
            return 0
        }
        
        return Int(unwrapped)
    }
}

public extension Swift.Optional where Wrapped == Double {
    
    func asDoubleOrEmpty() -> Double {
        guard let unwrapped = self,!(unwrapped.isNaN || unwrapped.isInfinite) else {
            return 0
        }
        return Double(unwrapped)
    }

}

public extension Swift.Optional where Wrapped == Bool {
    
    func asBoolOrFalse() -> Bool {
        guard let unwrapped = self else {
            return false
        }
        return Bool(unwrapped)
    }

}

public extension Swift.Optional where Wrapped == Float {
    
    func asFloatOrZero() -> Float {
        guard let unwrapped = self else {
            return 0
        }
        return Float(unwrapped)
    }
}

//
//  IntExtension.swift
//  House
//
//  Created by Ahmed samir ali on 3/25/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation


public extension Int {
    
    func numberWithCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        if let value = numberFormatter.string(from: NSNumber(value:self)){
            return value
        }
        return ""
    }
    
    var double: Double {
        return Double(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var string: String {
        return String(self)
    }
}



public extension Formatter {
    static let number = NumberFormatter()
}

public extension FloatingPoint {
    func fractionDigitsRounded(to digits: Int, roundingMode:  NumberFormatter.RoundingMode = .halfEven) -> String {
        Formatter.number.roundingMode = roundingMode
        Formatter.number.minimumFractionDigits = digits
        Formatter.number.maximumFractionDigits = digits
        return Formatter.number.string(for:  self) ?? ""
    }
}

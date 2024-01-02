//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 28/12/2023.
//

import Foundation

public extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}

public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

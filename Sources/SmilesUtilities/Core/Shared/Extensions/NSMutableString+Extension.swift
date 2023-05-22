//
//  NSMutableString+Extension.swift
//  House
//
//  Created by Shahroze Zaheer on 10/28/21.
//  Copyright © 2021 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit
public extension NSMutableString {
    func voucherPriceAttributedString(stringA: String, stringB: String, stringC: String) -> NSMutableAttributedString {
        let normalAttribute = [NSAttributedString.Key.foregroundColor: UIColor(red: 128, green: 128, blue: 128), NSAttributedString.Key.font: UIFont.latoRegularFont(size: 12)]
        let colorAttribute = [NSAttributedString.Key.foregroundColor: UIColor(red: 235, green: 128, blue: 36), NSAttributedString.Key.font: UIFont.latoRegularFont(size: 13)]
        let largeAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.latoRegularFont(size: 12)]
        
        let partOne = NSMutableAttributedString(string: "\(stringA) ", attributes: normalAttribute)
        let partTwo = NSMutableAttributedString(string: "\(stringB) ", attributes: colorAttribute)
        let partThree = NSMutableAttributedString(string: "\(stringC) ", attributes: largeAttribute)
        
        let combination = NSMutableAttributedString()
        
        combination.append(partOne)
        combination.append(partTwo)
        combination.append(partThree)
        
        return combination
    }
}

//
//  UIViewExtension.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 21/09/2022.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import UIKit

public extension UIView {
    func findViews<T: UIView>(subclassOf: T.Type) -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }
    
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
}

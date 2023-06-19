//
//  CGColorExtension.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 22/09/2022.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import UIKit

public extension CGColor {
    var uiColor: UIColor {
        return UIColor(cgColor: self)
    }
}

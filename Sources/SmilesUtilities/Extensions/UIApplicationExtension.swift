//
//  UIApplicationExtension.swift
//  YayOrNay
//
//  Created by MyAList on 11/23/18.
//  Copyright © 2018 Mahmoud Fathy. All rights reserved.
//

import Foundation
import UIKit
public extension UIApplication {
    
    public static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    
    public static var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    public static func baseViewController() -> UIViewController? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
    }
    
    public static func topMostViewController() -> UIViewController? {
        return baseViewController()?.topmostViewController()
    }
}


extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

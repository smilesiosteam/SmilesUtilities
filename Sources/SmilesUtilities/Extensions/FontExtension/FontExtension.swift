//
//  FontExtension.swift
//  House
//
//  Created by Ahmed samir ali on 9/4/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit
import SmilesLanguageManager

@objc public extension UIFont {
    @objc static func latoRegularFont(size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Regular", size: size)
    }
    
    @objc static func latoSemiBoldFont(size: CGFloat) -> UIFont {
        return customFont(name: "Lato-SemiBold", size: size)
    }
    
    @objc static func latoBoldFont(size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Bold", size: size)
    }
    
    @objc static func latoMediumFont(size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Medium", size: size)
    }
    
    @objc static func montserratRegularFont(size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Regular", size: size)
    }
    
    @objc static func montserratBoldFont(size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Bold", size: size)
    }
    
    @objc static func montserratMediumFont(size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Medium", size: size)
    }
    
    @objc static func montserratSemiBoldFont(size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-SemiBold", size: size)
    }
    
    @objc static func montserratExtraBoldFont(size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-ExtraBold", size: size)
    }
    
    @objc static func circularXXTTBoldFont(size: CGFloat) -> UIFont {
        return customFont(name: "CircularXXTT-Bold", size: size)
    }
    
    @objc static func circularXXTTBookFont(size: CGFloat) -> UIFont {
        return customFont(name: "CircularXXTT-Book", size: size)
    }
    
    @objc static func circularXXTTLightFont(size: CGFloat) -> UIFont {
        return customFont(name: "CircularXXTT-Light", size: size)
    }
    
    @objc static func circularXXTTMediumFont(size: CGFloat) -> UIFont {
        return customFont(name: "CircularXXTT-Medium", size: size)
    }
    
    @objc static func circularXXTTRegularFont(size: CGFloat) -> UIFont {
        return customFont(name: "CircularXXTT-Regular", size: size)
    }
    
    @objc static func thmTextStyle1(size: CGFloat) -> UIFont {
        return customFont(name: SmilesLanguageManager.shared.getLocalizedString(for: "NeoTechAlt"), size: size)
    }
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

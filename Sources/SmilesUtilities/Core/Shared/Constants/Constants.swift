//
//  Constants.swift
//  House
//
//  Created by Usman Tarar on 16/02/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit

public class SharedConstants: NSObject {
    static let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
    // MARK: - Screen Aspect Ratio
    public static let ASPECT_RATIO_RESPECT = ScreenSize.BASE_SCREEN_HEIGHT / ScreenSize.maxWH
    public static let ENABLE_EMAIL_VERIFICATION = true
    
    // MARK: - Device Screens Size
    public struct ScreenSize {
        public static let BASE_SCREEN_HEIGHT: CGFloat = 736.0
        public static let width = UIScreen.main.bounds.size.width
        public static let height = UIScreen.main.bounds.size.height
        public static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        public static let maxWH = max(ScreenSize.width, ScreenSize.height)
        public static let minWH = min(ScreenSize.width, ScreenSize.height)
    }
    
    // MARK: - Device Device Type
    
    public struct DeviceType {
        public static let iPhone4orLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH < 568.0
        public static let iPhone5orSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 568.0
        public static let iPhone678 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 667.0
        public static let iPhone678p = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 736.0
        public static let iPhone8orLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH <= 667.0
        public static let iPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 812.0
        public static let iPhoneXRMax = UIDevice.current.userInterfaceIdiom == .phone && SharedConstants.ScreenSize.maxWH == 896.0
        public static var hasNotch: Bool {
            return iPhoneX || iPhoneXRMax
        }
    }
    
    public struct Font {
        public static let regular = "Montserrat-Regular"
        public static let bold = "Montserrat-Bold"
        public static let semiBold = "Montserrat-Semibold"
    }   
}

public enum UserDefaultKeys {
    //tooltip
    public static let isToolTopShown = "isToolTopShown"
    // LocationState
    public static let locationSaver = "locationSaver"
    
    public static let recentLocationSaver = "recentLocationSaver"
    
    public static let locationRegistered = "locationRegistered"
    
    public static let shouldUpdateLocation = "shouldUpdateLocation"
    
    public static let updateLocationInHome = "updateLocationInHome"
    
    public static let hideLocationToolTip = "hideLocationToolTip"
    
    public static let showLocationToolTipOnHome = "showLocationToolTip"
    public static let showLocationToolTipOnRestaurant = "showLocationToolTipOnRestaurant"
    public static let iOSRatingState = "iOSRatingState"
}

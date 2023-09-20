//
//  UIColorExtensions.swift
//  YayOrNay
//
//  Created by Mahmoud Fathy on 8/3/18.
//  Copyright © 2018 Mahmoud Fathy. All rights reserved.
//

import UIKit

public extension UIColor {
    static var appOrangeColor: UIColor { return #colorLiteral(red: 0.9153117537, green: 0.5559968352, blue: 0.3027777076, alpha: 1) }
    static var navBarTitleColor: UIColor { return #colorLiteral(red: 0.3960784314, green: 0.7647058824, blue: 0.7254901961, alpha: 1) }
    static var disabledButtonsColor: UIColor { return #colorLiteral(red: 0.8196078431, green: 0.8235294118, blue: 0.8196078431, alpha: 1) }
    static var enabledButtonsColor: UIColor { return #colorLiteral(red: 0.5733847022, green: 0.4594194293, blue: 0.6540008187, alpha: 1) }
    static var errorsColor: UIColor { return #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1) }
    
    static var discountColor: UIColor { return #colorLiteral(red: 0.3970356286, green: 0.7645774484, blue: 0.7271444201, alpha: 1) }
    static var cashVoucherColor: UIColor { return #colorLiteral(red: 0.2196078431, green: 0.2823529412, blue: 0.4431372549, alpha: 1) }
    static var dealVoucherColor: UIColor { return #colorLiteral(red: 0.9153117537, green: 0.5559968352, blue: 0.3027777076, alpha: 1) }
    static var etisalatColor: UIColor { return #colorLiteral(red: 0.3970356286, green: 0.7645774484, blue: 0.7271444201, alpha: 1) }
    static var voucherPromotionalColor: UIColor { return #colorLiteral(red: 0.9058823529, green: 0.7254901961, blue: 0, alpha: 1) }
    static var applightGrey: UIColor { return #colorLiteral(red: 0.5176470588, green: 0.5294117647, blue: 0.537254902, alpha: 1) }

    static var lightGreenColor: UIColor { return #colorLiteral(red: 0.3970356286, green: 0.7645774484, blue: 0.7271444201, alpha: 1) }
    static var purpleColor: UIColor { return #colorLiteral(red: 0.5733847022, green: 0.4594194293, blue: 0.6540008187, alpha: 1) }
    static var darkGreyColor: UIColor { return #colorLiteral(red: 0.2156862745, green: 0.2196078431, blue: 0.2078431373, alpha: 1) }
    
    static var ramdanGradientBottomColor: UIColor { return #colorLiteral(red: 0.4941176471, green: 0.2705882353, blue: 0.6196078431, alpha: 1) }
    static var ramdanGradientTopColor: UIColor { return #colorLiteral(red: 0.5733847022, green: 0.4594194293, blue: 0.6540008187, alpha: 1) }
    static var toastSuccessColor: UIColor { return #colorLiteral(red: 0.4431372549, green: 0.6196078431, blue: 0.09803921569, alpha: 1) }
    static var toastWarningColor: UIColor { return #colorLiteral(red: 0.9058823529, green: 0.7254901961, blue: 0, alpha: 1) }
    
    static var deviceDiscountedPriceColor: UIColor { return #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1) }
    static var deviceNormalPriceColor: UIColor { return #colorLiteral(red: 0.2078431373, green: 0.2156862745, blue: 0.2196078431, alpha: 1) }

    static var homeToolTipPrimaryColor: UIColor { return #colorLiteral(red: 0.8862745098, green: 0.4784313725, blue: 0.2392156863, alpha: 1) }
    static var homeToolTipBorderPrimaryColor: UIColor { return #colorLiteral(red: 0.8117647059, green: 0.3019607843, blue: 0, alpha: 1) }
    
    static var disabledColor: UIColor { return #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1) }

    static var primaryLabelTextColor: UIColor { return #colorLiteral(red: 0.2078431373, green: 0.2156862745, blue: 0.2196078431, alpha: 1) }
    static var secondaryLabelTextColor: UIColor { return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1) }
    
    static var skipButtonTextColor: UIColor { return #colorLiteral(red: 0.5294117647, green: 0.3294117647, blue: 0.631372549, alpha: 1) }
    static var deleteButtonEnableColor: UIColor { return #colorLiteral(red: 0.8784313725, green: 0.2392156863, blue: 0.1490196078, alpha: 1) }
    static var deleteButtonDisableColor: UIColor { return #colorLiteral(red: 0.8784313725, green: 0.2392156863, blue: 0.1490196078, alpha: 0.35) }
    
    static var foodDisableColor: UIColor { return #colorLiteral(red: 0.4745098039, green: 0.4901960784, blue: 0.5529411765, alpha: 1) }
    static var foodEnableColor: UIColor { return #colorLiteral(red: 0.4588235294, green: 0.2588235294, blue: 0.5568627451, alpha: 1) }
    
//    static var secondaryLabelTextColor: UIColor { return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1) }
//    static var secondaryLabelTextColor: UIColor { return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1) }

    convenience init(_ rgbValue: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((rgbValue & 0xff0000) >> 16) / 256.0
        let green = CGFloat((rgbValue & 0xff00) >> 8) / 256.0
        let blue = CGFloat(rgbValue & 0xff) / 256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init?(hexColorWithAlpha hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F", "F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
    func colorWithHexString(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt64 {
        var hexInt: UInt64 = 0
        // Create scanner
        let scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt64(&hexInt)
        return hexInt
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xff,
            green: (rgb >> 8) & 0xff,
            blue: rgb & 0xff
        )
    }
}

@objc public extension UIColor {
    @objc static var tierBrownColor: UIColor { return UIColor(red: 175.0 / 255.0, green: 121.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0) }
    @objc static var tierSilverColor: UIColor { return UIColor(red: 141.0 / 255.0, green: 141.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0) }
    @objc static var tierGoldColor: UIColor { return UIColor(red: 182.0 / 255.0, green: 153.0 / 255.0, blue: 39.0 / 255.0, alpha: 1.0) }
    
    static var navGradientStart = UIColor(red: 135, green: 84, blue: 161)
    
    static var navGradientEnd = UIColor(red: 224, green: 61, blue: 38)
    
    static var subscriptionOnHoldColor: UIColor { return UIColor(red: 247.0 / 255.0, green: 193.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0) }
    
    static private var ramadanGradientEndColor = UIColor(red: 100/255, green: 112/255, blue: 157/255, alpha: 1)
    
    static private var ramadanGradientStartColor = UIColor(red: 200/255, green: 182/255, blue: 143/255, alpha: 1)

    
    static private var ramadanPointGradientStartColor = UIColor(red: 214/255, green: 195/255, blue: 143/255, alpha: 1)

    static private var ramadanPointGradientEndColor = UIColor(red: 247/255, green: 190/255, blue: 74/255, alpha: 0)

    static var appRedColor: UIColor { return UIColor(red: 224, green: 61, blue: 38) }
    
    static var redColorWithAlpha: UIColor { return UIColor(red: 224.0 / 255.0, green: 61.0 / 255.0, blue: 38.0 / 255.0, alpha: 0.2) }

    static var appLightGreenColor: UIColor { return UIColor(hex: "#56B8AB") }
    
    static var appLightGrayColor: UIColor { return UIColor(hex: "#F7F7F7") }
        
    static var appDarkGrayColorWithCode: UIColor { return UIColor(red: 241.0 / 255.0, green: 241.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0) }
    
    static var appDarkGrayColor: UIColor { return UIColor(red: 53.0 / 255.0, green: 55.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0) }
    
    static var appBlackColor: UIColor { return UIColor(red: 36.0 / 255.0, green: 36.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0) }
    
    static var appGreyColor_128: UIColor { return UIColor(red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0) }
    static var appGreyColor_1285: UIColor { return UIColor(red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0, alpha: 0.5) }

    static var appGreyColor_164: UIColor { return UIColor(red: 164.0 / 255.0, green: 164.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0) }
    
    static var appLabelDarkGrayColor: UIColor { return UIColor(hex: "#848789") }
   
    static var appLabelLightGrayColor: UIColor { return UIColor(red: 132.0 / 255.0, green: 135.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0) }
    
    static var appPurpleColor: UIColor { return UIColor(red: 127.0 / 255.0, green: 95.0 / 255.0, blue: 150.0 / 255.0, alpha: 1.0) }
    static var appPurpleColor1: UIColor { return UIColor(red: 135.0 / 255.0, green: 84.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0) }
    static var appPurpleColorWithOpacity: UIColor { return UIColor(red: 135.0 / 255.0, green: 84.0 / 255.0, blue: 161.0 / 255.0, alpha: 0.2) }
    static var appLightLightGrayColor: UIColor { return UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0) }
    
    static var deleteRedColor: UIColor { return UIColor(red: 204.0 / 255.0, green: 25.0 / 255.0, blue: 0 / 255.0, alpha: 1.0) }
    
    static var appLightGrayColor2: UIColor { return UIColor(red: 209.0 / 255.0, green: 209.0 / 255.0, blue: 209.0 / 255.0, alpha: 1.0) }
    
    static var statusFailedColor: UIColor { return UIColor(red: 190.0 / 255.0, green: 18.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0) }
    static var statusPendingColor: UIColor { return UIColor(red: 226.0 / 255.0, green: 122.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0) }
    static var statusSuccessfulColor: UIColor { return UIColor(red: 134.0 / 255.0, green: 84.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0) }
    
    static var appOrangeColorNew: UIColor { return UIColor(red: 235.0 / 255.0, green: 138.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0) }
    static var appOrangeColorNewWithZeroAlpha: UIColor { return UIColor(red: 247.0 / 255.0, green: 190.0 / 255.0, blue: 74.0 / 255.0, alpha: 0.0) }
    static var appOrangeColorNewWith3Alpha: UIColor { return UIColor(red: 247.0 / 255.0, green: 190.0 / 255.0, blue: 74.0 / 255.0, alpha: 0.3) }
    static var appOrangeColorWithAlpha: UIColor { return UIColor(red: 235.0 / 255.0, green: 138.0 / 255.0, blue: 36.0 / 255.0, alpha: 0.3) }
    
    static var appGreenColor: UIColor { return UIColor(red: 89.0 / 255.0, green: 194.0 / 255.0, blue: 194.0 / 255.0, alpha: 1.0) }
    
    static var appGreenSecondaryColor: UIColor { return UIColor(red: 69.0 / 255.0, green: 176.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0) }
    
    static var appButtonDisabledColor: UIColor { return UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0) }
    
    static var appRedSecondaryColor: UIColor { return UIColor(red: 204.0 / 255.0, green: 25.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0) }
    
    static var searchBarColor: UIColor { return UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 0.3) }

    static var placeholderTextFiedColor: UIColor { return UIColor(red: 164.0 / 255.0, green: 164.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0) }

    static var offersTextColor: UIColor { return UIColor(red: 60.0 / 255.0, green: 63.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0) }

    static var appLightDarkGrayColor: UIColor { return UIColor(red: 61.0 / 255.0, green: 55.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0) }

    static var lightPaigeGrayColor: UIColor { return UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0) }
    
    static var appBeidgeColor: UIColor { return UIColor(red: 250.0 / 255.0, green: 228.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0) }
    
    static var mapOrangeRouteColor: UIColor { return UIColor(red: 255.0 / 255.0, green: 96.0 / 255.0, blue: 21.0 / 255.0, alpha: 1.0) }
    
    static var appDarkTextGreyColor: UIColor { return UIColor(red: 60.0 / 255.0, green: 73.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0) }

    static var appYellowColor: UIColor { return UIColor(red: 255.0 / 255.0, green: 219.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0) }
    
    static var menuDisableColor: UIColor { return UIColor(red: 171.0 / 255.0, green: 171.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0) }

    static var appRevampFilterTextColor: UIColor { return UIColor(red: 19.0 / 255.0, green: 23.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0) }

    static var appRevampPurpleBGColor: UIColor { return UIColor(red: 47.0 / 255.0, green: 58.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0) }

    static var appRevampEnableStateColor: UIColor { return UIColor(red: 239.0 / 255.0, green: 240.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0) }

    static var appRevampLayerBorderColor: UIColor { return UIColor(red: 166.0 / 255.0, green: 168.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0) }
    
    static var appRevampFilterCountBGColor: UIColor { return UIColor(red: 66.0 / 255.0, green: 76.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0) }
   
    static var appRevampSubtitleColor: UIColor { return UIColor(red: 121.0 / 255.0, green: 125.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0) }

    static var appRevampClosingTextGrayColor: UIColor { return UIColor(red: 77.0 / 255.0, green: 81.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0) }
    
    static var appRevampLocationTextColor: UIColor { return UIColor(red: 19.0 / 255.0, green: 23.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0) }
    
    static var appRevampBorderGrayColor: UIColor { UIColor(red: 210.0 / 255.0, green: 212.0 / 255.0, blue: 217.0 / 255.0, alpha: 1) }
    
    static var appRevampHomeSearchColor: UIColor { UIColor(red: 121.0 / 255.0, green: 125.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0) }
    
    static var appRevampHomeCompactSearchColor: UIColor { UIColor(red: 226.0 / 255.0, green: 226.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0) }
    
    static var appRevampCellBorderGrayColor: UIColor { UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 236.0 / 255.0, alpha: 1) }
    
    static var appRevampPointsBGColor: UIColor { UIColor(red: 36.0 / 255.0, green: 26.0 / 255.0, blue: 41.0 / 255.0, alpha: 0.3) }

    static var appRevampSearchBGColor: UIColor { UIColor(red: 19.0 / 255.0, green: 23.0 / 255.0, blue: 40.0 / 255.0, alpha: 0.4) }

    static var appRevampPurpleMainColor: UIColor { return UIColor(red: 117.0 / 255.0, green: 66.0 / 255.0, blue: 142.0 / 255.0, alpha: 1.0) }
    
    static var appRevampItemTitleColor: UIColor { return UIColor(red: 56.0 / 255.0, green: 56.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0) }
    
    static var appRevampCollectionsTitleColor: UIColor { return UIColor(red: 61.0 / 255.0, green: 51.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0) }
    
    static var appRevampImageBackgroundColor: UIColor { return UIColor(red: 175.0 / 255.0, green: 175.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0) }

    static var appRevampWhiteBackgroundColor: UIColor { return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0) }
    
    @objc class func navigationGradientColorArray() -> [UIColor] {
        return [UIColor.appRevampPurpleMainColor]
    }
    
    @objc class func ramadanGradientColorArray() -> [UIColor] {
        return [UIColor.ramadanGradientStartColor, UIColor.ramadanGradientEndColor]
    }
    
    @objc class func ramadanPointsGradientColorArray() -> [UIColor] {
        return [UIColor.ramadanPointGradientStartColor, UIColor.ramadanPointGradientEndColor, UIColor.clear]
    }
    
    
    @objc static var appBrownColor: UIColor { return UIColor(red: 189.0 / 255.0, green: 134.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0) }
    @objc static var appRedColor3: UIColor { return UIColor(red: 204.0 / 255.0, green: 25.0 / 255.0, blue: 0 / 255.0, alpha: 1.0) }
    
    @objc static var fullGreyColor: UIColor { return UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233 / 255.0, alpha: 1.0) }
}

public extension UIColor {
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

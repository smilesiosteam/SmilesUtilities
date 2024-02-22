//
//  String.swift
//  House
//
//  Created by Ahmed samir ali on 1/27/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import CoreGraphics
import CryptoSwift
import Foundation
import UIKit
import SmilesLanguageManager
import SmilesFontsManager

public extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstProperties = unicodeScalars.first?.properties else {
            return false
        }
        return unicodeScalars.count == 1 &&
            (firstProperties.isEmojiPresentation ||
                firstProperties.generalCategory == .otherSymbol)
    }
    
    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool {
        return (unicodeScalars.count > 1 &&
            unicodeScalars.contains { $0.properties.isJoinControl || $0.properties.isVariationSelector })
            || unicodeScalars.allSatisfy { $0.properties.isEmojiPresentation }
    }
    
    var isEmoji: Bool {
        return self.isSimpleEmoji || self.isCombinedIntoEmoji
    }
}

@available(iOS 10.2, *)
public extension String {
    // MARK: - Constants
    
    static let trueValue = "true"
    static let falseValue = "false"
    static let emptyString = ""
    
    // MARK: - Tab bar String Constants
    
    // MARK: Home tab
    
    static let homeTabbarSelectedImage = "homeSelected"
    static let homeTabbarUnSelectedImage = "homeUnselected"
    static let homeTabbarTitle = "HomeTabTitle"
    
    // MARK: vouchers tab
    
    static let vouchersTabbarSelectedImage = "CouponsVoucherSelected"
    static let vouchersTabbarUnSelectedImage = "CouponsVoucherUnselected"
    static let vouchersTabbarTitle = "MyVoucherTitles"
    
    // MARK: billPayments tab
    
    static let billPaymentsTabbarSelectedImage = "BillSelected"
    static let billPaymentsTabbarUnSelectedImage = "BillUnselected"
    static let billPaymentsTabbarTitle = "BillsTabTitle"
    
    // MARK: gamification tab
    
    static let playTabbarSelectedImage = "playSelected"
    static let playTabbarUnSelectedImage = "playUnselected"
    static let playTabbarTitle = "PlayTabTitle"
    
    // MARK: BOGO tab
    
    static let UnlimitedBOGOSelected = "UnlimitedBOGOSelected"
    static let UnlimitedBOGOUnselected = "UnlimitedBOGOUnselected"
    static let bogoTabbarTitle = "bogoTabbarTitle"
    
    // MARK: profile tab
    
    static let profileTabbarSelectedImage = "ProfileSelected"
    static let profileTabbarUnSelectedImage = "ProfileUnselected"
    static let profileTabbarSelectedImageWithDot = "ProfileSelectedWithDot"
    static let profileTabbarUnSelectedImageWithDot = "ProfileUnselectedWithDot"
    static let profileTabbarTitle = "ProfileTitle"
    
    // MARK: Favorite tab
    
    static let favouritesTabbarSelectedImage = "iconFavorite"
    static let favouritesTabbarUnSelectedImage = "FavTab"
    static let favouritesTabbarTitle = "Favourites"
    
    // MARK: ExploreAll tab
    
    static let exploreAllTabbarSelectedImage = "exploreSelected"
    static let exploreAllTabbarUnSelectedImage = "exploreUnselected"
    static let exploreAllTabbarTitle = "Explore all"
    
    // CellIds
    
    static let moreCategoriesCellId = "moreCategoriesCellId"
    
    // MARK: Constansts
    
    static let promoFlag = "promoFlag"
    static let mocaLink = "mocaLink"
    static let msisdn = "msisdn"
    static let showOnboardScratchCard = "showCard"
    static let paymentSuccessfulFlag = "paymentSuccessfulFlag"
    static let notFirstTime = "firstTime"
    static let isOtpIn = "gamifiaction_optin"
    static let offerRedeemed = "offerRedeemed"
    static let isTreasureChestGame = "isTreasureChest"
    static let luckyDealSuccessfullyPurchaed = "luckyOfferPurchaed"
    static let showBirthdayPopUp = "showBirthdayPopUp"
    static let isLoggedOut = "isLoggedOut"
    static let cbdCoBandCard = "CBD"
    static let loyaltyID = "loyaltyID"
    static let rewardPoints = "rewardPoints"
    static let rewardPointsIcon = "rewardPointsIcon"
    static let shouldAnimateRewardsSmileyOnce = "shouldAnimateRewardsSmileyOnce"
    static let shouldAnimateRewardsSmiley = "shouldAnimateRewardsSmiley"

    var isSingleEmoji: Bool {
        return count == 1 && self.containsEmoji
    }
    
    var containsEmoji: Bool {
        return contains { $0.isEmoji }
    }
    
    var containsOnlyEmoji: Bool {
        return !isEmpty && !contains { !$0.isEmoji }
    }
    
    var emojiString: String {
        return self.emojis.map { String($0) }.reduce("", +)
    }
    
    var emojis: [Character] {
        return filter { $0.isEmoji }
    }
    
    var emojiScalars: [UnicodeScalar] {
        return filter { $0.isEmoji }.flatMap { $0.unicodeScalars }
    }
    
    // MARK: - Helper methods
    
    func convertToCodableModel<T: Codable>(ofType type: T.Type) -> T? {
        let jsonData = self.data(using: .utf8)!
        let decoder = JSONDecoder()
        return try? decoder.decode(type.self, from: jsonData)
    }
    
    mutating func replacingCharacter(value: String, startIndexOffsetBy: Int, endIndexOffsetBy: Int, replaceWith: String) {
        let start = self.index(value.startIndex, offsetBy: startIndexOffsetBy)
        let end = self.index(value.startIndex, offsetBy: endIndexOffsetBy)
        self.replaceSubrange(start..<end, with: replaceWith)
    }
    
    func showFirstName() -> String {
        let result = self.split(separator: " ")
        return String(result[safe: 0] ?? "")
    }
    
    // MARK: - Convert HTML to string
    
    func attributedString(withRegularFont regularFont: UIFont, andBoldFont boldFont: UIFont, fontColor: UIColor) -> NSMutableAttributedString {
        var attributedString = NSMutableAttributedString()
        guard let data = self.data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            attributedString = try NSMutableAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes: nil)
            let range = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: fontColor], range: range)
            attributedString.enumerateAttribute(NSAttributedString.Key.font, in: range, options: .longestEffectiveRangeNotRequired) { value, range, _ in
                let currentFont: UIFont = value as! UIFont
                var replacementFont: UIFont?
                
                if currentFont.fontName.contains("bold") || currentFont.fontName.contains("Bold") {
                    replacementFont = boldFont
                } else {
                    replacementFont = regularFont
                }
                
                let replacementAttribute = [NSAttributedString.Key.font: replacementFont!]
                attributedString.addAttributes(replacementAttribute, range: range)
            }
        } catch let e {
            print(e.localizedDescription)
        }
        return attributedString
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return NSAttributedString() }
        
        guard let htmlText = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return NSAttributedString()
        }
        return htmlText
    }

    
    var htmlToString: String {
        return self.htmlToAttributedString?.string ?? ""
    }
    
    func convertHtmlToAttributedStringWithCSS(font: UIFont?, csscolor: String, lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return self.htmlToAttributedString
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)"
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print(error)
            return nil
        }
    }
    
    // MARK: - Encrypt and decrypt Strings  using AES
    
    func aesEncrypt(key: String, iv: String) -> String {
        if let encrypted = try? AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!)) {
            return Data(encrypted).base64EncodedString()
        }
        return ""
    }
    
    func aesDecrypt(key: String, iv: String) -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
        if let decrypted = try? AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data)) {
            return String(bytes: decrypted, encoding: .utf8) ?? self
        }
        return ""
    }
    
    func aesDecryptForCaptcha(key: String, iv: String) -> String {
        guard let data = Data.init(base64Encoded: self, options: .ignoreUnknownCharacters) else { return "" }
        if let decrypted = try? AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data)) {
            return String(bytes: decrypted, encoding: .utf8) ?? self
        }
        return ""
    }

    
    // MARK: - Remove Whitespaces from string
    
    func removeWhitespacesFromString() -> String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func encodeEmoji() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    func decodeEmoji() -> String? {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    func encodeStringWithPercentEncoding() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeStringWithPercentEncoding() -> String? {
        return self.removingPercentEncoding
    }
    
    func allStringsBetween(start: String, end: String) -> [Any] {
        var strings = [Any]()
        var startRange: NSRange = (self as NSString).range(of: start)
        
        while true {
            if startRange.location != NSNotFound {
                var targetRange = NSRange()
                targetRange.location = startRange.location + startRange.length
                targetRange.length = self.count - targetRange.location
                let endRange: NSRange = (self as NSString).range(of: end, options: [], range: targetRange)
                if endRange.location != NSNotFound {
                    targetRange.length = endRange.location - targetRange.location
                    strings.append((self as NSString).substring(with: targetRange))
                    var restOfString = NSRange()
                    restOfString.location = endRange.location + endRange.length
                    restOfString.length = self.count - restOfString.location
                    startRange = (self as NSString).range(of: start, options: [], range: restOfString)
                } else {
                    break
                }
            } else {
                break
            }
        }
        return strings
    }
    
    func strikoutString(strikeOutColor withColor: UIColor) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: withColor, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func hexColorComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var cString: String = trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return (red: 0, green: 0, blue: 0)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        
        return (red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    func capitalizingEveryFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeEveryFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    
    
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while ranges.last.map({ $0.upperBound < self.endIndex }) ?? true,
              let range = self.range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale)
        {
            ranges.append(range)
        }
        return ranges
    }
    
    var localizedString: String {
        return SmilesLanguageManager.shared.getLocalizedString(for: self)
    }
    
    func NSRangeof(subString: String) -> NSRange {
        if let range = self.range(of: subString) {
            return NSRange(range, in: self)
        } else {
            return NSRange(location: 0, length: 0)
        }
    }
    
    func add(stringList: [String],
             font: UIFont,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 2,
             paragraphSpacing: CGFloat = 12,
             textColor: UIColor = .gray,
             bulletColor: UIColor = .green) -> NSAttributedString
    {
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for string in stringList {
            let formattedString = "\(bullet)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle: paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string = NSString(string: formattedString)
            let rangeForBullet: NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        return bulletList
    }
    
    var upperCamelCased: String {
        return self.lowercased()
            .split(separator: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }
    
    var lowerCamelCased: String {
        let upperCased = self.upperCamelCased
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }
    
    @MainActor func getAttributedString(style: UIFont.TextStyle, color: UIColor) -> NSAttributedString {
        
        guard let typography = Typography(for: style) else { return NSAttributedString(string: "") }
        let attrString = NSMutableAttributedString(string: self)
        let spacingString = NSMutableAttributedString(attributedString: attrString)
        let textRange = NSRange(location: 0, length: attrString.string.count)
        spacingString.addAttribute(NSAttributedString.Key.kern, value: typography.letterSpacing, range: textRange)
        spacingString.addAttributes([NSAttributedString.Key.font : typography.font()!], range: textRange)
        spacingString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: textRange)
        if let lineHeight = typography.textLineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            spacingString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, spacingString.length))
        }
        return spacingString
        
    }

    
}

public extension NSMutableAttributedString {
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

public extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func parseToInt() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
    
    var isAlphabetOnly: Bool {
        return !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    func trim(_ emptyToNil: Bool = true) -> String? {
        let text = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return emptyToNil && text.isEmpty ? nil : text
    }
    
    var lastWord: String? {
        if let size = self.lastIndex(of: " "), size >= self.startIndex {
            return String(self[size...]).trim()
        }
        return ""
    }
}

public extension Sequence where Iterator.Element == NSAttributedString {
    func joined(with separator: NSAttributedString) -> NSAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            r, e in
            if r.length > 0 {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joined(with separator: String = "") -> NSAttributedString {
        return self.joined(with: NSAttributedString(string: separator))
    }
}


public extension String {
    func boolValueFromString() -> Bool {
        return NSString(string: self).boolValue
    }
}
public extension String{
    func toUTCDate()->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        if let date1 = dateFormatter.date(from: self) {
            return date1
        }
        return nil
    }
    
    func toUTCDate(format: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        if let date1 = dateFormatter.date(from: self) {
            return date1
        }
        return nil
    }
}
extension String: LocalizedError {
    public var errorDescription: String? { return self.localizedString }
}

extension NSObject {
   public static var className: String {
        return String(describing: self)
    }
}

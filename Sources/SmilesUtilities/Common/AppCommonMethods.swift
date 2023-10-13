//
//  AppCommonMethods.swift
//  House
//
//  Created by Usman Tarar on 15/07/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SmilesLanguageManager
import SmilesFontsManager

public class AppCommonMethods {
    
    public static var serviceBaseUrl: String {
        let plistInfo = Bundle.main.infoDictionary
        if let value = plistInfo?["MAIN_URL"] as? String {
            return value.replacingOccurrences(of: "\\", with: "")
        }
        return ""
    }
    
    public static var isGuestUser: Bool {
        if let msisdn = UserDefaults.standard.string(forKey: .msisdn), !msisdn.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    public static func loadJson(forFilename fileName: String) -> NSDictionary? {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                    
                    return dictionary
                } catch {
                    print("Error!! Unable to parse  \(fileName).json")
                }
            }
            print("Error!! Unable to load  \(fileName).json")
        }
        
        return nil
    }
    
    
    public static func languageIsArabic() -> Bool {
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            return true
        }
        return false
    }
    
    public static func setCollectionViewForArabic(_ collectionView: UICollectionView) {
        DispatchQueue.main.async {
            collectionView.transform = .identity
            if AppCommonMethods.languageIsArabic() {
                collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
                collectionView.semanticContentAttribute = .forceRightToLeft
            } else {
                collectionView.semanticContentAttribute = .forceLeftToRight
            }
        }
    }
    
    public static func setViewForArabic(_ view: UIView) {
        DispatchQueue.main.async {
            view.transform = .identity
            if AppCommonMethods.languageIsArabic() {
                view.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
        }
    }
    
    public static func getAutoWidthWith(_ title: String, font: UIFont, additionalWidth: CGFloat = 0.0) -> CGFloat {
        let label = UILabel(frame: CGRect.zero)
        label.font = font
        label.text = title
        label.sizeToFit()
        return label.frame.width + additionalWidth
    }
    
    public static func getAutoWidthWith(_ title: String, fontTextStyle: UIFont.TextStyle, additionalWidth: CGFloat = 0.0) -> CGFloat {
        let label = UILabel(frame: CGRect.zero)
        label.fontTextStyle = fontTextStyle
        label.text = title
        label.sizeToFit()
        return label.frame.width + additionalWidth
    }
    
    public static func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
    
    public static func call(phoneNumber: String) {
        OperatorUtility().callNumber(number: phoneNumber)
    }
    
    public static func openMap(latitude: Double, longitude: Double) {
        
        let regionDistance:CLLocationDistance = 0
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = ""
        
        
        
        let application = UIApplication.shared
        let coordinate = "\(latitude),\(longitude)"
        let encodedTitle = ""
        let handlers = [
            ("Apple", "http://maps.apple.com/?q=\(encodedTitle)&ll=\(coordinate)"),
            ("Google", "comgooglemaps://?q=\(coordinate)"),
            ("Waze", "waze://?ll=\(coordinate)"),
            ("Citymapper", "citymapper://directions?endcoord=\(coordinate)&endname=\(encodedTitle)")
        ]
            .compactMap { (name, address) in URL(string: address).map { (name, $0) } }
            .filter { (_, url) in application.canOpenURL(url) }
        
        guard handlers.count > 1 else {
            if let (_, _) = handlers.first {
                mapItem.openInMaps(launchOptions: options)
            }
            return
        }
        let alert = UIAlertController(title:"", message: nil, preferredStyle: .actionSheet)
        handlers.forEach { (name, url) in
            alert.addAction(UIAlertAction(title: name, style: .default) { _ in
                application.open(url, options: [:])
            })
        }
        alert.addAction(UIAlertAction(title: "btn_Cancel".localizedString, style: .cancel, handler: nil))
        
        //        if let topVC = UIApplication.getTopViewController() {
        //            topVC.present(alert, animated: true, completion: nil)
        //        }
    }
    
    public static func getWithAEDValue(string: String) -> String {
        let doubleValue = string.toDouble().asDoubleOrEmpty()
        if AppCommonMethods.languageIsArabic() {
            return "\(String(format: "%.2f", doubleValue)) \("AED".localizedString)"
        } else {
            return "\("AED".localizedString) \(String(format: "%.2f", doubleValue))"
        }
    }
    
    public static func getFormatedTime(expireDate: String) -> Double? {
        let dateToExpire = AppCommonMethods.returnDate(from: expireDate, format: "yyyy-MM-dd HH:mm:ss")
        if let dealExpiryDate = dateToExpire {
            let dateGMT = Date()
            let secondFromGMT = TimeInterval(TimeZone.current.secondsFromGMT(for: Date()))
            let currentDate = dateGMT.addingTimeInterval(secondFromGMT)
            
            if dealExpiryDate >= currentDate {
                let timeDifference: TimeInterval = dealExpiryDate.timeIntervalSince(currentDate)
                return  timeDifference
            }
        }
        return nil
    }
    
    public static func returnDate(from dateString:String, format:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: dateString)
    }
    
    public static func convert(date:Date,format:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        // No need to convert date to Arabic
//        if SmilesLanguageManager.shared.currentLanguage == .ar {
//            dateFormatter.locale = Locale(identifier: "ar_SA")
//        }
        let gregianCalendar = Calendar(identifier: .gregorian)
        dateFormatter.calendar = gregianCalendar
        return dateFormatter.string(from: date)
    }
    public static func getWithAEDValuePrefix(string: String) -> String {
        let doubleValue = string.toDouble().asDoubleOrEmpty()
        return "\(String(format: "%.2f", doubleValue)) \("AED".localizedString)"
    }
    
    public static func getWithPTSValue(string: String) -> String {
        let doubleValue = string.toDouble().asDoubleOrEmpty()
        if AppCommonMethods.languageIsArabic() {
            return "\("PTS".localizedString) \(String(format: "%.2f", doubleValue))"
        } else {
            return "\(String(format: "%.2f", doubleValue)) \("PTS".localizedString)"
        }
    }
    public static func getColorCodedStarImage(for rating: Double) -> UIImage {
        switch rating{
        case 0.0...2.0:
            return #imageLiteral(resourceName: "redfillstaricon")
        case 2.0...3.0:
            return #imageLiteral(resourceName: "yellowfilledstaricon")
        case 0.0...5.0:
            return #imageLiteral(resourceName: "greenfilledstaricon")
        default:
            return #imageLiteral(resourceName: "yellowfilledstaricon")
        }
    }
    public static func getColor(for rating: Double) -> UIColor {
        switch rating{
        case 0.0...2.0:
            return UIColor(red: 224.0 / 255.0, green: 61.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
        case 2.0...3.0:
            return UIColor(red: 1.0, green: 213.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
        case 0.0...5.0:
            return UIColor(red: 69.0 / 255.0, green: 176.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
        default:
            return UIColor(red: 1.0, green: 213.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
        }
    }
    
    public static func loadCustomObject(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    public static func getConfigurationForCurrentScheme(_ key: String?) -> String? {
        let plistInfo = Bundle.main.infoDictionary
        let value = plistInfo?[key ?? ""] as? String
        return value != nil ? value?.replacingOccurrences(of: "\\", with: "") : " "
    }
    
    public static func getResourcesFromPlist(resource: String) -> [String: Any] {
        var plistFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData = [String: Any]()
        let plistPath = Bundle.main.path(forResource: resource, ofType: "plist")
        if let plistContent = FileManager.default.contents(atPath: plistPath.asStringOrEmpty()) {
            do {
                plistData = try PropertyListSerialization.propertyList(from: plistContent, options: .mutableContainersAndLeaves, format: &plistFormat) as? [String: Any] ?? [:]
            } catch {
                debugPrint("Error reading plist: \(error), format: \(plistFormat)")
            }
        }
        
        return plistData
    }
    
    public static func getLocalizedArray(forKey key: String) -> [Any]? {
        let englishResources = getResourcesFromPlist(resource: "English_Resources")
        let arabicResources = getResourcesFromPlist(resource: "Arabic_Resources")
        
        if !languageIsArabic() {
            if let englishData = englishResources[key] {
                return englishData as? [Any]
            }
        } else {
            if let arabicData = arabicResources[key] {
                return arabicData as? [Any]
            }
        }
        
        return []
    }
    
    public static func extractYoutubeId(fromLink link: String) -> String {
        let regexString: String = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regExp = try? NSRegularExpression(pattern: regexString, options: .caseInsensitive)
        let array: [Any] = (regExp?.matches(in: link, options: [], range: NSRange(location: 0, length: (link.count ))))!
        if array.count > 0 {
            let result: NSTextCheckingResult? = array.first as? NSTextCheckingResult
            return (link as NSString).substring(with: (result?.range)!)
        }
        
        return ""
    }
    
    public static func extractThumbnailFromYoutube(url: String) -> String {
        let youtubeID = extractYoutubeId(fromLink: url)
        return "https://i.ytimg.com/vi/\(youtubeID)/hqdefault.jpg"
    }
    
    public static func applyLocalizedStringsToAllViews(_ view: UIView) {
        for subView in view.subviews {
            if subView.subviews.count > 0 {
                // UIView
                applyLocalizedStringsToAllViews(subView)
            }
            else if let button = subView as? UIButton {
                // UIButton
                if button.tag == 90 {
                    if SmilesLanguageManager.shared.currentLanguage == .ar {
                        button.transform = CGAffineTransform(scaleX: -1, y: 1)
                    } else {
                        button.transform = CGAffineTransform.identity
                    }
                }
                
                if let hint = button.accessibilityHint, !hint.isEmpty {
                    button.setTitle(SmilesLanguageManager.shared.getLocalizedString(for: button.accessibilityLabel ?? ""), for: .normal)
                }
            }
            
            else if let label = subView as? UILabel {
                // UILabel
                if let hint = label.accessibilityHint, !hint.isEmpty {
                    label.text = SmilesLanguageManager.shared.getLocalizedString(for: label.accessibilityHint ?? "")
                }
            }
            else if let textField = subView as? UITextField {
                // UITextField
                if let hint = textField.accessibilityHint, !hint.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        textField.placeholder = SmilesLanguageManager.shared.getLocalizedString(for: textField.accessibilityHint ?? "")
                    }
                }
            }
            else if let textView = subView as? UITextView {
                // UITextView
                if let hint = textView.accessibilityHint, !hint.isEmpty {
                    textView.text = SmilesLanguageManager.shared.getLocalizedString(for: textView.accessibilityHint ?? "")
                }
            }
            else if let imageView = subView as? UIImageView {
                // UIImageView
                if let hint = imageView.accessibilityHint, !hint.isEmpty {
                    imageView.image = UIImage(named: SmilesLanguageManager.shared.getLocalizedString(for: imageView.accessibilityHint ?? ""))
                }
            }
        }
    }
    
    public static func getStringBetweenTags(_ HTMLString: String, startTag: String, endTag: String) -> String? {
        guard let rangeStart = HTMLString.range(of: startTag) else {
            return nil
        }
        
        guard let rangeEnd = HTMLString.range(of: endTag, options: .literal, range: rangeStart.upperBound..<HTMLString.endIndex) else {
            return nil
        }
        
        let contentRange = rangeStart.upperBound..<rangeEnd.lowerBound
        return String(HTMLString[contentRange])
    }
    
    public static func removeCustomObject(withKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public static func getViewController(fromStoryboardName storyboardName: String, withIdentifier identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    public static func serializeDictionaryObject(_ modelDictionary: [String: Any]) -> Data? {
        do {
            // Serialize the dictionary
            let json = try JSONSerialization.data(withJSONObject: modelDictionary, options: .prettyPrinted)
            return json
        } catch {
            print("Error serializing dictionary to JSON: \(error)")
            return nil
        }
    }

}

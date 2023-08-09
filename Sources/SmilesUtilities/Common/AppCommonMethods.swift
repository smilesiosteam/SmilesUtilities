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
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            dateFormatter.locale = Locale(identifier: "ar_SA")
        }
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
    
    func isToBeFlipped(withView view: UIView) -> Bool {
        var tag = 0
        
        if let uiImageView = view as? UIImageView {
            tag = uiImageView.tag
        } else if let uiButton = view as? UIButton {
            tag = uiButton.tag
        } else if let uiView = view as? UIView {
            tag = uiView.tag
        } else if let uiTextView = view as? UITextView {
            tag = uiTextView.tag
        } else if let uiTextField = view as? UITextField {
            tag = uiTextField.tag
        } else if let uiLabel = view as? UILabel {
            tag = uiLabel.tag
        } else if let uiSegmentedControl = view as? UISegmentedControl {
            tag = uiSegmentedControl.tag
        }
        
        return (tag != SharedConstants.nonFlippedViewTag)
    }
    
    public static func adjustSubviewsLanguage(view: UIView, withoutFlipping toBeFlipped: Bool) {
        for subview in view.subviews {
            let isToBeFlipped = self.isToBeFlipped(withView: subview)
            
            if isToBeFlipped {
                if toBeFlipped {
                    subview.frame = CGRect(x: view.frame.size.width - subview.frame.origin.x - subview.frame.size.width, y: subview.frame.origin.y, width: subview.frame.size.width, height: subview.frame.size.height)
                }
            }
            
            if let buttonView = subview as? UIButton {
                if buttonView.accessibilityHint?.count > 0 {
                    let newString = SmilesLanguageManager.shared.getLocalizedString(for: buttonView.accessibilityHint ?? "")
                    buttonView.setTitle(newString.removingPercentEncoding, for: .normal)
                }
            } else if let plainView = subview as? UIView, plainView.subviews.count > 0 {
                if plainView.tag != SharedConstants.nonFlippedViewTag {
                    self.adjustSubviewsLanguage(view: plainView, toBeFlipped: toBeFlipped)
                }
            } else if let labelView = subview as? UILabel {
                if labelView.accessibilityHint.count > 0 {
                    let newString = SmilesLanguageManager.shared.getLocalizedString(for: labelView.accessibilityHint ?? "")
                    labelView.text = newString.removingPercentEncoding
                }
                
                if (!(labelView.textAlignment == .center) && isToBeFlipped) {
                    if labelView.tag != SharedConstants.flippedViewWithoutAlignmentChangedTag {
                        if toBeFlipped {
                            if labelView.textAlignment == .right {
                                labelView.textAlignment = .left
                            } else {
                                labelView.textAlignment = .right
                            }
                        }
                    }
                }
            } else if let textFieldView = subview as? UITextField {
                if textFieldView.accessibilityHint.count > 0 {
                    let delayInMilliSeconds = 10
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delayInMilliSeconds)) {
                        let newString = SmilesLanguageManager.shared.getLocalizedString(for: textFieldView.accessibilityHint ?? "")
                        textFieldView.placeholder = newString.removingPercentEncoding
                    }
                }
                
                if (!(textFieldView.textAlignment == .center) && isToBeFlipped) {
                    if textFieldView.tag != SharedConstants.flippedViewWithoutAlignmentChangedTag {
                        if toBeFlipped {
                            if languageIsArabic() {
                                textFieldView.textAlignment = .right
                            } else {
                                textFieldView.textAlignment = .left
                            }
                        }
                    }
                }
            } else if let textView = subview as? UITextView {
                if textView.tag != SharedConstants.flippedViewWithoutAlignmentChangedTag {
                    if toBeFlipped {
                        if languageIsArabic() {
                            textView.textAlignment = .right
                        } else {
                            textView.textAlignment = .left
                        }
                    }
                }
            }
        }
    }
}

//
//  UILabelExtension.swift
//  House
//
//  Created by Ahmed samir ali on 5/16/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit
import SmilesLanguageManager

public extension UILabel {
    func updateAttributedTextTo(string: String, subString: String, stringColor: UIColor = .appLabelLightGrayColor, subStringColor: UIColor = .appLabelLightGrayColor, fontsize: CGFloat = 12.0) {
        let attributedString = NSMutableAttributedString(string: string, attributes: [
            .font: UIFont(name: "Lato-Regular", size: fontsize)!,
            .foregroundColor: stringColor,
            .kern: 0.0
        ])
        attributedString.addAttributes([
            .font: UIFont.latoBoldFont(size: fontsize),
            .foregroundColor: subStringColor
        ], range: string.NSRangeof(subString: subString))
        
        self.attributedText = attributedString
    }
    
    func updateAttributedText(string: String, subString: String, stringColor: UIColor = .appLabelLightGrayColor, subStringColor: UIColor = .appLabelLightGrayColor, fontsize: CGFloat = 13.0) {
        let attributedString = NSMutableAttributedString(string: string, attributes: [
            .font: UIFont(name: "Lato-Semibold", size: fontsize)!,
            .foregroundColor: stringColor,
            .kern: 0.0
        ])
        attributedString.addAttributes([
            .font: UIFont.latoBoldFont(size: fontsize),
            .foregroundColor: subStringColor
        ], range: string.NSRangeof(subString: subString))
        
        self.attributedText = attributedString
    }
    
    func underline(color: UIColor) {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            let range = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
            attributedText = attributedString
        }
    }
    
    func updateLabelTextStyle(fullText: String, styledText: String, fullStringAttributes: [NSAttributedString.Key: Any], styledStringAttributes: [NSAttributedString.Key: Any]) {
        let style = NSMutableParagraphStyle()
        if AppCommonMethods.languageIsArabic() {
            style.alignment = .right
        } else {
            style.alignment = .left
        }
        style.minimumLineHeight = 2.0
        let attributedString = NSMutableAttributedString(string: fullText, attributes: fullStringAttributes)
        attributedString.addAttributes(styledStringAttributes, range: fullText.NSRangeof(subString: styledText))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullText.NSRangeof(subString: styledText))
        self.attributedText = attributedString
    }
    
    func updateLabelForMultipleTextStyle(fullText: String, styledText: String, subStyledText: String, fullStringAttributes: [NSAttributedString.Key: Any], styledStringAttributes: [NSAttributedString.Key: Any], subStyledStringAttributes: [NSAttributedString.Key: Any]) {
        let style = NSMutableParagraphStyle()
        if AppCommonMethods.languageIsArabic() {
            style.alignment = .right
        } else {
            style.alignment = .left
        }
        style.minimumLineHeight = 2.0
        let attributedString = NSMutableAttributedString(string: fullText, attributes: fullStringAttributes)
        attributedString.addAttributes(styledStringAttributes, range: fullText.NSRangeof(subString: styledText))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullText.NSRangeof(subString: styledText))
        
        attributedString.addAttributes(subStyledStringAttributes, range: fullText.NSRangeof(subString: subStyledText))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullText.NSRangeof(subString: subStyledText))
        self.attributedText = attributedString
    }
    
    func countLabelLines() -> Int {
        if let myText = self.text {
            let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
            let charSize = font.lineHeight
            let textSize = myText.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font ?? UIFont()], context: nil)
            let linesRoundedUp = Int(ceil(textSize.height / charSize))
            return linesRoundedUp
        }
        return 0
    }
    
    func isTruncated(targetLines: Int) -> Bool {
        if self.countLabelLines() > targetLines {
            return true
        }
        return false
    }
}

public extension UILabel {
    
    func addTrailing(with trailingText: String, fullText: String, textFont: UIFont = .latoRegularFont(size: 12), textColor: UIColor = .appGreyColor_128, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        
        let readMoreText: String = trailingText + moreText
        
        if self.visibleTextLength == 0 { return }
        
        let lengthForVisibleString: Int = self.visibleTextLength
        
        if let myText = self.text {
            
            let mutableString: String = myText
            
            let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: myText.count - lengthForVisibleString), with: "")
            
            let readMoreLength: Int = (readMoreText.count)
            
            guard let safeTrimmedString = trimmedString else { return }
            
            if safeTrimmedString.count <= readMoreLength { return }
            
            // "safeTrimmedString.count - readMoreLength" should never be less then the readMoreLength because it'll be a negative value and will crash
            let trimmedForReadMore: String = (safeTrimmedString as NSString).replacingCharacters(in: NSRange(location: safeTrimmedString.count - readMoreLength, length: readMoreLength), with: "") + trailingText
            
            let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: textFont])
            let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
            answerAttributed.append(readMoreAttributed)
            self.attributedText = answerAttributed
        }
    }
    
    var visibleTextLength: Int {
        
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        if let myText = self.text {
            
            let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
            let attributedText = NSAttributedString(string: myText, attributes: attributes as? [NSAttributedString.Key : Any])
            let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
            
            if boundingRect.size.height > labelHeight {
                var index: Int = 0
                var prev: Int = 0
                let characterSet = CharacterSet.whitespacesAndNewlines
                repeat {
                    prev = index
                    if mode == NSLineBreakMode.byCharWrapping {
                        index += 1
                    } else {
                        index = (myText as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: myText.count - index - 1)).location
                    }
                } while index != NSNotFound && index < myText.count && (myText as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
                return prev
            }
        }
        
        if self.text == nil {
            return 0
        } else {
            return self.text!.count
        }
    }
    
    func formatLabelStyle(fullText: String, styledText: [String], fullStringAttributes: [NSAttributedString.Key: Any], styledStringAttributes: [[NSAttributedString.Key: Any]]) {
        let attributedString = NSMutableAttributedString(string: fullText, attributes: fullStringAttributes)
        if styledText.isEmpty {
        } else if styledText.count == 1 {
            if let text = styledText.first {
                attributedString.addAttributes(styledStringAttributes[0], range: fullText.NSRangeof(subString: text))
                self.attributedText = attributedString
            } else {
                self.text = fullText
            }
        } else if styledText.count > 1 {
            for (index, element) in styledText.enumerated() {
                let attributedStyle = styledStringAttributes[index]
                attributedString.addAttributes(attributedStyle, range: fullText.NSRangeof(subString: element))
            }
        } else {
            self.text = fullText
        }
        self.attributedText = attributedString
    }
}


public extension UILabel {
    func addBadge(label: UILabel, badgeCount: String, backgroundColor: UIColor, textColor: UIColor) {
        DispatchQueue.main.async {
            label.text = "\(badgeCount)" // note spaces before and after text
            label.backgroundColor = backgroundColor
            label.textColor = textColor
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.clipsToBounds = true
            label.layer.cornerRadius = label.frame.size.height / 2.0
            //            label.sizeToFit()
        }
    }
}

public extension UILabel {
    func addTrailing(image: UIImage, iconSize: CGRect) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = iconSize
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: self.text ?? "" + "  ", attributes: [:])
        
        string.append(attachmentString)
        self.attributedText = string
    }
}

public extension UILabel {
    // MARK: - Custom Flags
    
    private enum AssociatedKeys {
        static var isCopyingEnabled: UInt8 = 0
        static var shouldUseLongPressGestureRecognizer: UInt8 = 1
        static var longPressGestureRecognizer: UInt8 = 2
    }
    
    /// Set this property to `true` in order to enable the copy feature. Defaults to `false`.
    
    @IBInspectable var isCopyingEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isCopyingEnabled, newValue, .OBJC_ASSOCIATION_ASSIGN)
            self.setupGestureRecognizers()
        }
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKeys.isCopyingEnabled)
            return (value as? Bool) ?? false
        }
    }
    
    /// Used to enable/disable the internal long press gesture recognizer. Defaults to `true`.
    @IBInspectable var shouldUseLongPressGestureRecognizer: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shouldUseLongPressGestureRecognizer, newValue, .OBJC_ASSOCIATION_ASSIGN)
            self.setupGestureRecognizers()
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.shouldUseLongPressGestureRecognizer) as? Bool) ?? true
        }
    }
    
    @objc
    var longPressGestureRecognizer: UILongPressGestureRecognizer? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.longPressGestureRecognizer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.longPressGestureRecognizer) as? UILongPressGestureRecognizer
        }
    }
    
    // MARK: - UIResponder
    
    @objc
    override var canBecomeFirstResponder: Bool {
        return self.isCopyingEnabled
    }
    
    @objc
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Only return `true` when it's the copy: action AND the `copyingEnabled` property is `true`.
        return (action == #selector(self.copy(_:)) && self.isCopyingEnabled)
    }
    
    @objc
    override func copy(_ sender: Any?) {
        if self.isCopyingEnabled {
            // Copy the label text
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        }
    }
    
    // MARK: - UI Actions
    
    @objc internal func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer === self.longPressGestureRecognizer, gestureRecognizer.state == .began {
            becomeFirstResponder()
            
            let copyMenu = UIMenuController.shared
            copyMenu.arrowDirection = .default
            if #available(iOS 13.0, *) {
                copyMenu.showMenu(from: self, rect: bounds)
            } else {
                // Fallback on earlier versions
                copyMenu.setTargetRect(bounds, in: self)
                copyMenu.setMenuVisible(true, animated: true)
            }
        }
    }
    
    // MARK: - Private Helpers
    
    fileprivate func setupGestureRecognizers() {
        // Remove gesture recognizer
        if let longPressGR = longPressGestureRecognizer {
            removeGestureRecognizer(longPressGR)
            self.longPressGestureRecognizer = nil
        }
        
        if self.shouldUseLongPressGestureRecognizer, self.isCopyingEnabled {
            isUserInteractionEnabled = true
            // Enable gesture recognizer
            let longPressGR = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(self.longPressGestureRecognized(gestureRecognizer:)))
            self.longPressGestureRecognizer = longPressGR
            addGestureRecognizer(longPressGR)
        }
    }
    
    var maxNumberOfLines: Int {
        guard let text = text, let font = font else {
            return 0
        }
        
        let charSize = font.lineHeight
        
        let textSize = (text as NSString).boundingRect(
            with: CGSize(width: UIScreen.main.bounds.width - 32, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil)
        
        let linesRoundedUp = Int(ceil(textSize.height / charSize))
        return linesRoundedUp
    }
}

public extension UILabel {
    func setTextSpacingBy(value: Double) {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}


extension UILabel {
    public func setLineHeight(lineHeight: CGFloat) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight

        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}

extension UILabel {
   public func setAlignment() {
        let isRightToLeft = SmilesLanguageManager.shared.isRightToLeft
        self.textAlignment =  isRightToLeft ? .right : .left
    }
}


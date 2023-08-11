//
//  BaseLabel.swift
//  House
//
//  Created by Usman Tarar on 07/05/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesLanguageManager

@IBDesignable
public class BaseLabel: UILabel {
    
    @IBInspectable public var setUpperCase: Bool = false {
        didSet {
            _setupLabel()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setupLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupLabel()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        _setupLabel()
    }
    
    private func _setupLabel() {
        applyStyles()
        setNeedsDisplay()
        
        if setUpperCase {
            self.text = self.text?.uppercased()
        }
    }
    
    // Locale: -
    private func setComponentLocale() {
        if let hint = self.accessibilityHint {
            self.text = hint.localizedString
        }
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            semanticContentAttribute = .forceRightToLeft
            textAlignment = .right
        } else {
            semanticContentAttribute = .forceLeftToRight
            textAlignment = .left
        }
    }
    
    // MARK: - Styles
    
    private func applyStyles() {
        setComponentLocale()
    }
}








@IBDesignable
public class BaseTextField: UITextField {
    
    @IBInspectable public var setUpperCase: Bool = false {
        didSet {
            _setupLabel()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setupLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupLabel()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        _setupLabel()
    }
    
    private func _setupLabel() {
        applyStyles()
        setNeedsDisplay()
        
        if setUpperCase {
            self.text = self.text?.uppercased()
        }
    }
    
    // Locale: -
    private func setComponentLocale() {
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            semanticContentAttribute = .forceRightToLeft
            textAlignment = .right
        } else {
            semanticContentAttribute = .forceLeftToRight
            textAlignment = .left
        }
    }
    
    // MARK: - Styles
    
    private func applyStyles() {
        setComponentLocale()
    }
    
    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: 16, dy: 0)
    }
}

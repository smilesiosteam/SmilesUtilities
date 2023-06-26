//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 19/06/2023.
//

import Foundation
import UIKit
import SmilesFontsManager
import SmilesLanguageManager

@IBDesignable
public class TextFieldWithValidation: UITextField {
    public override var placeholder: String?{
        didSet{
            if !(placeholder?.isEmpty ?? true) {
                updatePlaceHolder()
            }
        }
    }
    public var continousValidation = false
    public override var text: String? {
        didSet{
            if continousValidation {
                _ = isDataValid
            }
            setBorderColor()
            updateBackground()
        }
    }
    
    private var errorLabel = UILabel()
    @IBInspectable public var paddingLeft: CGFloat = 12
    @IBInspectable public var paddingRight: CGFloat = 12
    @IBInspectable public var paddingTop: CGFloat = 7
    @IBInspectable public var paddingBottom: CGFloat = 7
    @IBInspectable public var localizedPlaceholder: String = "" {
        didSet {
            let localized = SmilesLanguageManager.shared.getLocalizedString(for: localizedPlaceholder)
            self.placeholder = localized.isEmpty ? localizedPlaceholder : localized
        }
    }
    private var errorMessage: String = "" {
        didSet {
            if errorMessage.isEmpty {
                hideErrorMessage()
            } else {
                showErrorMessage()
            }
        }
    }
    public var customErrorMessage = ""
    private var textTrimmedSpacing: String {
        return text?.trimmingCharacters(in: .whitespaces) ?? ""
    }
    private var paddingYErrorLabel: CGFloat = 4
    private let errorLabelHeight: CGFloat = 18
    
    public var validationType = [ValidatorType]()
    public var isDataValid: Bool {
        guard let text = text else { return false}
        var isValid = true
        for validation in validationType {
            do {
                try text.validatedText(validationType: validation)
            } catch (let error) {
                if customErrorMessage.isEmpty {
                    errorMessage = (error as! ValidationError).message
                } else {
                    errorMessage = customErrorMessage
                }
                isValid = false
                break
            }
        }
        return isValid
    }
    public var shakeTextField = true
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight))
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight))
    }
    
    private func setupViews() {
        
        borderStyle = .none
        layer.cornerRadius = 12
        layer.borderWidth = 1
        textColor = .black.withAlphaComponent(0.9)
        fontTextStyle = .smilesTitle1
        setBorderColor()
        setupErrorLabel()
        addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        updatePlaceHolder()
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            semanticContentAttribute = .forceRightToLeft
            textAlignment = .right
        }else{
            semanticContentAttribute = .forceLeftToRight
            textAlignment = .left
        }
    }
    
    @objc private func didChangeText(_ sender: UITextField) {
        
        if !errorLabel.isHidden {
            errorMessage = ""
            hideErrorMessage()
        }
        if continousValidation{
            _ = isDataValid
        }
        updateBackground()
        setBorderColor()
    }
    func updateBackground(){
        if (self.backgroundColor != .white) == !(self.text?.isEmpty ?? true) {
            UIView.animate(withDuration: 0.2, animations: {
                self.backgroundColor = self.text?.isEmpty ?? true ? UIColor(white: 0.95, alpha: 1) : .white
            })
        }
    }
    func setBorderColor(isDefault: Bool = true) {
        layer.borderColor = isDefault ? ((text?.isEmpty ?? true) ? UIColor.clear.cgColor : UIColor.black.withAlphaComponent(0.2).cgColor) : UIColor(hex: "cc1900").cgColor
    }
    
    private func setupErrorLabel() {
        
        errorLabel.frame = .zero
        errorLabel.font = SmilesFonts.lato.getFont(style: .semiBold, size: 11)
        errorLabel.numberOfLines = 1
        errorLabel.minimumScaleFactor = 0.5
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textColor = UIColor(hex: "cc1900")
        errorLabel.isHidden = true
        addSubview(errorLabel)
        
    }
    
    private func showErrorMessage() {
        
        setBorderColor(isDefault: false)
        if shakeTextField {
            shake()
        }
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
        errorLabel.frame = self.bounds
        errorLabel.sizeToFit()
        invalidateIntrinsicContentSize()
        
    }
    
    private func hideErrorMessage() {
        
        setBorderColor()
        errorLabel.text = ""
        errorLabel.isHidden = true
        errorLabel.frame = CGRect.zero
        invalidateIntrinsicContentSize()
        
    }
    
    private func shake() {
        
        let propertyAnimator = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.2) { [weak self] in
            self?.transform = CGAffineTransform(translationX: 0, y: 10)
        }
        
        propertyAnimator.addAnimations({ [weak self] in
            self?.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.addCompletion { (_) in
            
        }
        propertyAnimator.startAnimation()
        
    }
    
    override public var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        
        let textFieldIntrinsicContentSize = super.intrinsicContentSize
        
        if !errorMessage.isEmpty {
            return CGSize(width: textFieldIntrinsicContentSize.width,
                          height: textFieldIntrinsicContentSize.height + paddingYErrorLabel + errorLabel.bounds.size.height + errorLabelHeight)
        }else{
            return CGSize(width: textFieldIntrinsicContentSize.width,
                          height: textFieldIntrinsicContentSize.height + errorLabelHeight)
        }
    }
    func updatePlaceHolder(){
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder.asStringOrEmpty(), attributes:[
            NSAttributedString.Key.foregroundColor: UIColor(hex:"797D8D"),
            NSAttributedString.Key.font: UIFont.circularXXTTBookFont(size: 16)
        ])
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !errorMessage.isEmpty {
            var lblErrorFrame = errorLabel.frame
            lblErrorFrame.origin.y = frame.size.height + paddingYErrorLabel
            errorLabel.frame = lblErrorFrame
        }
    }
    
}

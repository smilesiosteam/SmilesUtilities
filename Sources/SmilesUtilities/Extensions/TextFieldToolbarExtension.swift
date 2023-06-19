//
//  TextFieldToolbar.swift
//  House
//
//  Created by Ahmed samir ali on 2/4/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit
import SmilesLanguageManager
public extension UITextField {
    
    @IBInspectable var placeHolderTextColor: UIColor? {
              get {
                  return self.placeHolderTextColor
              }
              set {
               self.attributedPlaceholder = NSAttributedString(string:self.placeholder.asStringOrEmpty(), attributes:[NSAttributedString.Key.foregroundColor: newValue!])
              }
          }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: SmilesLanguageManager.shared.getLocalizedString(for: "DoneTitle"), style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
     
        self.inputAccessoryView = doneToolbar
        self.layoutSubviews()
        self.setNeedsLayout()
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}


private var __maxLengths = [UITextField: Int]()
public extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/06/2023.
//

import Foundation
import UIKit
import SmilesLanguageManager

@IBDesignable
public class UILocalizableLabel: UILabel {
    
    // button corner radius
    @IBInspectable public var localizedString: String = "" {
        didSet {
            self.text = SmilesLanguageManager.shared.getLocalizedString(for: localizedString)
        }
    }
    
}

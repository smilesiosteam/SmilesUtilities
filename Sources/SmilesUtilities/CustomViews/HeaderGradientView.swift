//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/06/2023.
//

import Foundation
import UIKit

public class HeaderGradientView: UIView {
    
    private var colors: [UIColor] = [UIColor(red: 117/255, green: 66/255, blue: 142/255, alpha: 1), UIColor(red: 66/255, green: 76/255, blue: 153/255, alpha: 1)] {
        didSet {
            setupGradient()
        }
    }
    private let gradientLayer = CAGradientLayer()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setupGradient()
        NotificationCenter.default.addObserver(self, selector: #selector(setupGradient), name: NSNotification.Name("NotificationLanguageChangeIdentifier"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NotificationLanguageChangeIdentifier"), object: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.frame
    }
    
    @objc private func setupGradient() {
        
        gradientLayer.colors = colors.map { $0.cgColor }
        if AppCommonMethods.languageIsArabic() {
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        gradientLayer.locations = [0.0 , 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}

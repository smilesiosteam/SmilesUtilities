//
//  ButtonExentsion.swift
//  House
//
//  Created by Ahmed samir ali on 10/16/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    func updateButtonStyle(withCornerRadious corner: CGFloat, borderColor color: UIColor, borderWidth width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = corner
    }
    func styleButtonText(text : String, attr : [NSAttributedString.Key: Any]){
        let underlineAttributedString = NSAttributedString(string: text, attributes: attr)
        self.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    
    func underlineButtonText(text : String){
        let attributes : [NSAttributedString.Key: Any] = [
            .font :self.titleLabel!.font!,
            .foregroundColor : self.currentTitleColor,
            .underlineStyle : NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(underlineAttributedString, for: .normal)
    }
}

public extension UIButton {
    private func actionHandler(action: (() -> Void)? = nil) {
        struct __ { static var action: (() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }

    @objc private func triggerActionHandler() {
        self.actionHandler()
    }

    func actionHandler(controlEvents control: UIControl.Event, ForAction action: @escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(self.triggerActionHandler), for: control)
    }
}

public extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(self.imageWithColor(color: color), for: state)
    }
    func setImageWithUrlString(_ urlString: String?, defaultImage: String? = "", state: UIControl.State) {
        if let imageURL = URL(string: urlString ?? "") {
            self.sd_setImage(with: imageURL, for: state)
        }
        else {
            self.setImage(UIImage(named: defaultImage ?? ""), for: state)
        }
    }
    
}

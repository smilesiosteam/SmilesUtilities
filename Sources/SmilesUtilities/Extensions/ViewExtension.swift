//
//  ViewExtension.swift
//  House
//
//  Created by Ahmed samir ali on 2/5/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView
import SmilesLanguageManager

public extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}

public extension UIView {
    private static let lineDashPattern: [NSNumber] = [6, 3] // 7 is the length of dash, 3 is length of the gap.
    private static let lineDashWidth: CGFloat = 1.0
    
    func makeDashedBorderLine() {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = UIView.lineDashWidth
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = UIView.lineDashPattern
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height / 2),
                                CGPoint(x: bounds.maxX, y: bounds.height / 2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        self.clipsToBounds = true
    }
    
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
    func RoundedViewConrner(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    func addShodow(shadowOffset offset: CGSize, withShadowColor color: UIColor, withShadowOpacity opacity: Float, withShadowRadius radius: CGFloat, withMaskedCorner corner: CACornerMask?) {
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 7
        
        if let maskerConrner = corner {
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = maskerConrner // top right, bottom right
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func addShadowToSelf(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = .clear
        layer.backgroundColor = backgroundCGColor
    }
    
    func addMaskedCorner(withMaskedCorner corner: CACornerMask, cornerRadius: CGFloat) {
        clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = corner // top right, bottom right
    }
    
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 2.0, offset: CGSize = CGSize(width: 0.0, height: 0.0)) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 0.5).cgColor
        self.layer.shadowOpacity = 1.0
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.bounds.width
        var viewHeight = self.bounds.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y - 10))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight + 20))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight + 20))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y - 10))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    
    func bindFrameToSuperviewBounds(topSpace:CGFloat? = 0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: topSpace ?? 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
    
    func changeStatusBarColor(color: UIColor) {
        let window = SharedConstants.keyWindow
        lazy var statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        self.addSubview(statusbarView)
        
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        statusbarView.heightAnchor
            .constraint(equalToConstant: statusBarHeight).isActive = true
        statusbarView.widthAnchor
            .constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        statusbarView.topAnchor
            .constraint(equalTo: self.topAnchor).isActive = true
        statusbarView.centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func addBorder(withBorderWidth width: CGFloat, borderColor color: UIColor) {
        clipsToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func enableSkeleton(){
        var views:[UIView] = [self]
        while !views.isEmpty {
            let view = views.removeLast()
            view.isSkeletonable = true
            views.append(contentsOf: view.subviews)
        }
    }
}

@objc public extension UIView {
    @objc enum GradientColorDirection: Int {
        case vertical = 0
        case horizontal = 1
        case diagnolLeftToRight = 2
    }
    
    func addGradientColors(_ colors: [UIColor], opacity: Float = 1, direction: GradientColorDirection = .vertical) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(0.3))) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.opacity = opacity
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.name = "gradientLayer"
            
            if direction == .horizontal {
                if AppCommonMethods.languageIsArabic() {
                    gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
                    gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
                } else {
                    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
                }
            } else if direction == .diagnolLeftToRight {
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            }
            
            gradientLayer.bounds = self.bounds
            gradientLayer.anchorPoint = CGPoint.zero
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func removeGradientColor() {
        for item in self.layer.sublayers ?? [] where item.name == "gradientLayer" {
            item.removeFromSuperlayer()
        }
    }
    
    func roundSpecifiCorners(corners: UIRectCorner = [.allCorners], radius: CGFloat) {
        let mask = CAShapeLayer()
        mask.position = self.center
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        mask.bounds = frame
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addToWindow() {
        if let window = SharedConstants.keyWindow{
            self.frame = window.bounds
            window.addSubview(self)
        }
    }
}

public extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func instantiate(autolayout: Bool = true) -> Self {
        // generic helper function
        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            let view = self.nib.instantiate() as! T
            view.translatesAutoresizingMaskIntoConstraints = !autolayout
            return view
        }
        return instantiateUsingNib(autolayout: autolayout)
    }
    
    static func generateSectionView(title: String, textColor: UIColor = .appDarkGrayColor, font: UIFont = UIFont.montserratSemiBoldFont(size: 16)) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.backgroundColor = .white
        label.textColor = textColor
        label.font = font
        label.text = "   \(title.localizedString)"
        return label
    }
    
}

public extension UIButton {
    func setGradientBackgroundColors(_ colors: [UIColor], direction: ImageGradientDirection, for state: UIControl.State) {
        if colors.count > 1 {
            // Gradient background
            setBackgroundImage(UIImage(size: CGSize(width: 1, height: 1), direction: direction, colors: colors), for: state)
        } else {
            if let color = colors.first {
                // Mono color background
                setBackgroundImage(UIImage(color: color, size: CGSize(width: 1, height: 1)), for: state)
            } else {
                // Default background color
                setBackgroundImage(nil, for: state)
            }
        }
    }
    
    func setGradientBorderColors(_ colors: [CGColor], borderWidth: CGFloat, gradientOrientation: BorderGradientOrientation) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.colors =  colors
        gradient.startPoint = gradientOrientation.startPoint
        gradient.endPoint = gradientOrientation.endPoint
        
        let shape = CAShapeLayer()
        shape.lineWidth = borderWidth
        
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
}

public enum BorderGradientOrientation {
    typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)
    
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}

public enum ImageGradientDirection {
    case toLeft
    case toRight
    case toTop
    case toBottom
    case toBottomLeft
    case toBottomRight
    case toTopLeft
    case toTopRight
}

public extension UIImage {
    convenience init?(size: CGSize, direction: ImageGradientDirection, colors: [UIColor]) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil } // If the size is zero, the context will be nil.
        
        guard colors.count >= 1 else { return nil } // If less than 1 color, return nil
        
        if colors.count == 1 {
            // Mono color
            let color = colors.first!
            color.setFill()
            
            let rect = CGRect(origin: CGPoint.zero, size: size)
            UIRectFill(rect)
        } else {
            // Gradient color
            var locations: [CGFloat] = []
            
            for (index, _) in colors.enumerated() {
                let index = CGFloat(index)
                locations.append(index / CGFloat(colors.count - 1))
            }
            
            guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colors.compactMap { $0.cgColor.components }.flatMap { $0 }, locations: locations, count: colors.count) else {
                return nil
            }
            
            var startPoint: CGPoint
            var endPoint: CGPoint
            
            switch direction {
            case .toLeft:
                startPoint = CGPoint(x: size.width, y: size.height / 2)
                endPoint = CGPoint(x: 0.0, y: size.height / 2)
            case .toRight:
                startPoint = CGPoint(x: 0.0, y: size.height / 2)
                endPoint = CGPoint(x: size.width, y: size.height / 2)
            case .toTop:
                startPoint = CGPoint(x: size.width / 2, y: size.height)
                endPoint = CGPoint(x: size.width / 2, y: 0.0)
            case .toBottom:
                startPoint = CGPoint(x: size.width / 2, y: 0.0)
                endPoint = CGPoint(x: size.width / 2, y: size.height)
            case .toBottomLeft:
                startPoint = CGPoint(x: size.width, y: 0.0)
                endPoint = CGPoint(x: 0.0, y: size.height)
            case .toBottomRight:
                startPoint = CGPoint(x: 0.0, y: 0.0)
                endPoint = CGPoint(x: size.width, y: size.height)
            case .toTopLeft:
                startPoint = CGPoint(x: size.width, y: size.height)
                endPoint = CGPoint(x: 0.0, y: 0.0)
            case .toTopRight:
                startPoint = CGPoint(x: 0.0, y: size.height)
                endPoint = CGPoint(x: size.width, y: 0.0)
            }
            
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions())
        }
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        
        self.init(cgImage: image)
        
        defer { UIGraphicsEndImageContext() }
    }
    
    convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        
        self.init(cgImage: image)
        
        defer { UIGraphicsEndImageContext() }
    }
}

public class BaseImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        _setupImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupImageView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        _setupImageView()
    }
    
    private func _setupImageView() {
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else {
            self.transform = .identity
        }
    }
}

public extension UIView {
    func roundTopWithShadowOnTop(radius : CGFloat){
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowOpacity = 0.16
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    func roundCorners(with corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

//
//  UIImageViewExtension.swift
//  House
//
//  Created by ahmed samir on 11/08/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import Foundation
import SDWebImage

public extension UIImageView {
    func makeRounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setProfileImageWithUrlString(_ urlString: String, defaultImage: String? = "") {
        if let imageURL = URL(string: urlString) {
            SDImageCache.shared.removeImage(forKey: urlString) {
                self.sd_setImage(with: imageURL, placeholderImage: UIImage(named: defaultImage ?? ""))
            }
        }
        else {
            self.image = UIImage(named: defaultImage ?? "")
        }
    }

    func setImageWithUrlString(_ urlString: String, defaultImage: String? = "") {
        if let imageURL = URL(string: urlString) {
            self.sd_setImage(with: imageURL, placeholderImage: UIImage(named: defaultImage ?? ""))
        }
        else {
            self.image = UIImage(named: defaultImage ?? "")
        }
    }
    
    func setImageWithUrlString(_ urlString: String, defaultImage: String? = "", backgroundColor: UIColor? = .appRevampImageBackgroundColor, completionBlock: @escaping (_ image: UIImage?) -> ()) {
        if let imageURL = URL(string: urlString) {
            self.sd_setImage(with: imageURL) { (image, error, type, url) in
                if (error != nil) {
                    self.backgroundColor = backgroundColor
                } else {
                    completionBlock(image)
                }
            }
        }
        else {
            self.image = UIImage(named: defaultImage ?? "")
            completionBlock(self.image)
        }
    }
}

extension UIImage {
    func mergeWith(topImage: UIImage) -> UIImage {
        let bottomImage = self

        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)

        let areaSizetopImage = CGRect(x: (bottomImage.size.width - 40)/2, y: (bottomImage.size.height - 40)/2, width: 40, height: 40)
        topImage.draw(in: areaSizetopImage, blendMode: .normal, alpha: 1.0)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
}

public extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}

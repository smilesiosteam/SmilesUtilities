//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 02/06/2023.
//

import Foundation
import UIKit

public extension UINavigationController {
    func addTabbarItem(title: String, selectedImageName: String, imageName image: String) {
        self.isNavigationBarHidden = true
        self.tabBarItem = UITabBarItem()
        self.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        self.tabBarItem.title = title
    }

    func popViewController() {
        self.popViewController(animated: true)
    }

    func popToRootViewController() {
        self.popToRootViewController(animated: true)
    }

    func pushViewController(viewController: UIViewController) {
        self.pushViewController(viewController, animated: true)
    }
}

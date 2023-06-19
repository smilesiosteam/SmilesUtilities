//
//  UIViewController.swift
//  House
//
//  Created by Usman Tarar on 12/07/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
public typealias CallbackCustomAlertVC = (_ isDeleted: Bool) -> Void

// MARK: - extension

public extension UIViewController {
    // MARK: properties
    
    func dismissMe(completion: ((Bool) -> Void)? = nil) {
        if let navigationViewController = self.navigationController {
            if navigationViewController.viewControllers.count >= 1 {
                self.dismissPushedController()
            } else {
                self.dismissPresentedController()
            }
            
        } else {
            self.dismissPresentedController()
        }
        completion?(true)
    }
    
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
     func dismissPushedController() {
        _ = navigationController?.popViewController(animated: true)
    }
    
     func dismissPresentedController(completion: ((Bool) -> Void)? = nil) {
        dismiss(animated: true, completion: { () -> Void in
            completion?(true)
        })
    }
    
    func showAlertWith(message: String, title: String = "", completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "YES".localizedString, style: .default, handler: completion)
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "CANCEL".localizedString, style: .cancel, handler: completion)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertWithOkayOnly(message: String, title: String = "", completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK".localizedString, style: .default, handler: completion)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    func topmostViewController() -> UIViewController {
        if let navigationVC = self as? UINavigationController,
            let topVC = navigationVC.topViewController {
            return topVC.topmostViewController()
        }
        if let tabBarVC = self as? UITabBarController,
            let selectedVC = tabBarVC.selectedViewController {
            return selectedVC.topmostViewController()
        }
        if let presentedVC = presentedViewController {
            return presentedVC.topmostViewController()
        }
        if let childVC = children.last {
            return childVC.topmostViewController()
        }
        return self
    }
}

public extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController.isKind(of: toControllerType) {
                    navigationController?.popToViewController(currentViewController, animated: true)
                    break
                }
            }
        }
    }
}



public extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow}?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

public extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}

//
//  ViperRouter.swift
//  Private
//
//  Created by Usman Tarar on 20/09/2020.
//  Copyright © 2020 UsmanTarar. All rights reserved.
//

import UIKit
import Foundation

open class BaseRouter {
    public class func setupModule() -> BaseViewController {
        return BaseViewController()
    }
}

public protocol ViperRouter {
    func navigateToViewController(viewController: UIViewController)
    func presentViewControllerAsPanModel(viewController: UIViewController&PanModalPresentable)
    func popToViewController(viewController: AnyClass)
    func presentViewController(vc: UIViewController)
    func presentGuestLogin(vc: UIViewController?)
}

extension ViperRouter {
    public func navigateToViewController(viewController: UIViewController) {}
    public func presentViewControllerAsPanModel(viewController: UIViewController&PanModalPresentable) {}
    public func popToViewController(viewController: AnyClass) {}
    public func presentViewController(vc: UIViewController) {}
    public func presentGuestLogin(vc: UIViewController?) {}
    
//    func presentGuestLogin(vc: UIViewController?) {
//        if let controller = vc {
//            let guestVC = GuestUserLoginPopupRouter.setupModule()
//            guestVC.prevNavigation = controller.navigationController
//            guestVC.modalPresentationStyle = .overFullScreen
//            controller.navigationController?.present(guestVC, animated: true)
//        }
//    }
}

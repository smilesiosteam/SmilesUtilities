//
//  UIViewController.swift
//  House
//
//  Created by Usman Tarar on 12/07/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesFontsManager
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

extension UIViewController {
    // MARK: properties
    
    // UIViewController storyboard ID
    static var storyboardID: String {
        return "\(self)"
    }
    
    // MARK: - Handler method
    
    // instatiate UIViewController instance
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    // MARK: enum
    
    // Storyboard name
    enum AppStoryboard: String {
        case DiscountAndDetails
        case HomeMamba
        case CustomizeCategories
        case MoreHomeCategories
        case SetUserLocation
        case ConfirmUserLocation
        case SearchLocation
        case RestaurantHome
        case UpdateLoction
        case LocationAccessAlert
        case RestaurantDetails
        case FoodMenuContent
        case MenuConfig
        case UpdateFoodItemQuantity
        case FoodCart
        case SelectPaymentMethod
        case EnterAddressDetail
        case PaymentCheckout
        case PaymentStatus
        case CheckoutPayments
        case RestaurantFilter
        case RestaurantMenuSearch
        case RestaurantInfo
        case RestaurantBranches
        case RestaurantSorting
        case RestaurantListing
        case OrderConfirmation
        case SearchCategoriesListing
        case OrderSummary
        case OrderFullList
        case TrackOrderOnMap
        case TrackOrderOnSupport
        case ErrorRetry
        case CashOnDelivery
        case NoTrackingOrder
        case CancelOrder
        case MyOrder
        case OffersAndVouchers
        case ApplyPromoCode
        case EmailVerification
        case CustomPopup
        case EnterPersonalDetails
        case ConfirmOrderPickUp
        case RewardsCard
        case TransactionsList
        case MyTransactionDetail
        case MyTransactionsFilters
        case RestaurantDetailRevamp
        case EditProfile
        case Profile
        case Favourites
        case SearchHomeMamba
        case GlobalSearch
        case RamadanDonationInfo
        case BOGO
        case CBDDetailsRevamp
        case ChangePayment
        case ManageSubscription
        case BogoSummary
        case ChangeCardRevamp
        case BillPaymentMainRevamp
        case BillPaymentRevamp
        case SpinTheWheel
        case SpinTheWheelRules
        case SpinTheWheelGiftDetails
        case SpinTheWheelPrizes
        case VouchersRevamp
        case VoucherInstructions
        case ImagePreview
        case CaptchaValidation
        case SubscriptionRevamp
        case SubcriptionViewAll
        case SubscriptionOrderSummary
        case ManageAndCancelSubscription
        case SubscriptionSummary
        case SubscriptionPromoCode
        case SubscriptionPopUp
        case StandAloneSpecialOffer
        case SubscriptionApplyGiftCard
        case QRCodeScanner
        case TotalLifeTimeSavings
        case RateOrder
        case RateDeliveryAndFood
        case ApplyPromoCodeForOffers
        case PromoCodeDetailsPage
        case EPG
        case ScrollableVouchers
        case RestaurantEnhancement
        case AccountDeletion
        case ConfirmDeletion
        case ReturnToLogin
        case FoodOrderHome
        case HomeCategories
        case PopularRestaurants
        case GuestUserLoginPopup
        case BirthdayPopup
        case Birthday
        
        var instance: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: Bundle.main)
        }
        
        func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
            
            let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
            return self.instance.instantiateViewController(withIdentifier: storyboardID) as! T
        }
        
        func initialViewController() -> UIViewController? {
            return self.instance.instantiateInitialViewController()
        }
    }
    
    func setNavigationBarTitle(_ title: String, withLargeTitles largeTitle: Bool, withClearStyle: Bool = false) {
        navigationItem.title = title
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = withClearStyle ? .clear : .appRevampPurpleMainColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: SmilesFonts.circular.getFont(style: .medium, size: 16)]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: SmilesFonts.circular.getFont(style: .medium, size: 23)]
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            
            UINavigationBar.appearance().tintColor = withClearStyle ? .clear : .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
            self.navigationController?.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.navigationBar.prefersLargeTitles = largeTitle
            
        } else {
            UINavigationBar.appearance().tintColor = withClearStyle ? .clear : .white
            UINavigationBar.appearance().barTintColor = withClearStyle ? .clear : .white
            UINavigationBar.appearance().isTranslucent = false
        }
                
        let btnBack: UIButton = UIButton()
        if AppCommonMethods.languageIsArabic() {
            btnBack.setImage(UIImage(named: withClearStyle ? "BackArrow_black_Ar" : "backIcon_Ar"), for: .normal)
        }else{
            btnBack.setImage(UIImage(named: withClearStyle ? "BackArrow_black" : "backIcon"), for: .normal)
        }
        btnBack.addTarget(self, action: #selector(self.onClickBack), for: .touchUpInside)
        btnBack.frame = CGRect(x: 0, y: 0, width: 45 / 2, height: 40 / 2)
        let barButton = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    func setNavigationBarTitleView(_ titleView: UIView?) {
        self.navigationItem.titleView = titleView

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .appRevampPurpleMainColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: SmilesFonts.circular.getFont(style: .medium, size: 16)]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: SmilesFonts.circular.getFont(style: .medium, size: 23)]
            UINavigationBar.appearance().barTintColor = .appRevampPurpleMainColor
            UINavigationBar.appearance().isTranslucent = false
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationItem.largeTitleDisplayMode = .never
            
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .white
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = .appRevampPurpleMainColor
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.layoutIfNeeded()
        
        let btnBack: UIButton = UIButton()
        if AppCommonMethods.languageIsArabic() {
            btnBack.setImage(UIImage(named: "BackArrow_right_black")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            btnBack.setImage(UIImage(named: "BackArrow_black")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        btnBack.addTarget(self, action: #selector(self.onClickBack), for: .touchUpInside)
        btnBack.frame = CGRect(x: 0, y: 0, width: 45 / 2, height: 40 / 2)
        let barButton = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItem = barButton
    }

    @objc func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }

//    func presentGuestLogin() {
//        let guestVC = GuestUserLoginPopupRouter.setupModule()
//        guestVC.prevNavigation = self.navigationController
//        guestVC.modalPresentationStyle = .overFullScreen
//        self.navigationController?.present(guestVC, animated: true)
//    }
    
}

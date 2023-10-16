//
//  UIStoryboard+Factory.swift
//  hkImperatorMensa
//
//  Copyright © 2018 Anderson Gusmao. All rights reserved.
//

import UIKit

extension UIStoryboard {
   public static var homeStoryboard: UIStoryboard {
        return UIStoryboard(name: "Home_new", bundle: nil)
    }
    
    public static var couponsAndVouchersStoryboard: UIStoryboard {
        return UIStoryboard(name: "CouponsAndVouchers", bundle: nil)
    }
    
    public static var htmlTextViewStoryboard: UIStoryboard {
          return UIStoryboard(name: "HTMLTextView", bundle: nil)
      }
    
     static var deviceV2Storyboard: UIStoryboard {
        return  UIStoryboard(name: "DeviceShopV2", bundle: nil)
    }

    public static var PaymentStatusStoryboard: UIStoryboard {
        return UIStoryboard(name: "PaymentStatus", bundle: nil)
    }
    
    public static var PlayAndWinStoryboard: UIStoryboard {
        return UIStoryboard(name: "Gamification", bundle: nil)
    }
    
    public static var profileStoryboard: UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
    
    public static var deviceShopStoryboard: UIStoryboard {
        return UIStoryboard(name: "DeviceShop", bundle: nil)
    }
    
    public static var changeMobileNumberStoryboard: UIStoryboard {
        return UIStoryboard(name: "ChangeMobileNumber", bundle: nil)
    }
    
    public static var discountOfferDetailsNumberStoryboard: UIStoryboard {
        return UIStoryboard(name: "DiscountOfferDetails", bundle: nil)
    }

    
    public static var oldHomeStoryboard: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }
    
    public static var gamificationStoryboard: UIStoryboard {
        return UIStoryboard(name: "Gamification", bundle: nil)
    }
    
    public static var checkoutPayments: UIStoryboard {
        return UIStoryboard(name: "CheckoutPayments", bundle: nil)
    }
    
    public static var yallaCompareStoryBoard: UIStoryboard {
        return  UIStoryboard(name: "YallaCompare", bundle: nil)
    }
    
    public static var sideMenuStoryboard: UIStoryboard {
        return UIStoryboard(name: "SideMenu", bundle: nil)
    }
    
    public static var loginStoryboard: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    public static var bogoStoryboard: UIStoryboard {
        return UIStoryboard(name: "BOGO", bundle: nil)
    }
    
    
    public static var inAppGiftingStoryboard: UIStoryboard {
        return UIStoryboard(name: "InAppGifting", bundle: nil)
    }
    
    public static var treasureChestStoryboard: UIStoryboard {
        return UIStoryboard(name: "TreasureChest", bundle: nil)
    }
    
    public static var becomeAPartner: UIStoryboard {
        return UIStoryboard(name: "BecomeAPartner", bundle: nil)
    }
    
    
    public static var pointExchangeStoryboard: UIStoryboard {
        return UIStoryboard(name: "PointsExchange", bundle: nil)
    }
    
    public static var summaryStoryboard: UIStoryboard {
        return UIStoryboard(name: "Summary", bundle: nil)
    }
    
    public static var actionSheetStoryboard: UIStoryboard {
        return UIStoryboard(name: "ActionSheet", bundle: nil)
    }
    
    public static var historyStoryboard: UIStoryboard {
        return UIStoryboard(name: "History", bundle: nil)
    }
    
    public static var conversionDetailStoryboard: UIStoryboard {
        return UIStoryboard(name: "ConversionDetail", bundle: nil)
    }
    
    public static var pointExchangeV2Storyboard: UIStoryboard {
        return UIStoryboard(name: "PointsExchangeV2", bundle: nil)
    }
    
    public static var birthDayStoryboard: UIStoryboard {
        return UIStoryboard(name: "Birthday", bundle: nil)
    }
    
    public static var searchStoryboard: UIStoryboard {
        return  UIStoryboard(name: "Search", bundle: nil)
    }
    
    
    public static var cbdCreditCardsStoryboard: UIStoryboard {
        return UIStoryboard(name: "CBDCreditCards", bundle: nil)
    }
    
    public static var linkedAccountsStoryboard: UIStoryboard {
           return UIStoryboard(name: "LinkedAccounts", bundle: nil)
       }
    
    public static var FavouritesStoryboard: UIStoryboard {
           return UIStoryboard(name: "Favourites", bundle: nil)
       }
    
    public static var ChangeMobileNumberStoryboard: UIStoryboard {
           return UIStoryboard(name: "ChangeMobileNumber", bundle: nil)
       }

    public static var GlobalSearchStoryboard: UIStoryboard {
           return UIStoryboard(name: "GlobalSearch", bundle: nil)
       }
    
    
    public static var cbdCreditCardsRevampStoryboard: UIStoryboard {
        return UIStoryboard(name: "CBDDetailsRevamp", bundle: nil)
    }
    

    //Favourites
  
    public func instantiateViewController<T>(ofType type: T.Type) -> T {
        guard let instance = instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Oops!")
        }
        return instance
    }
    
    public func instantiateController<T>(ofType type: T.Type) -> T {
        guard let instance = instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Oops!")
        }
        return instance
    }
}



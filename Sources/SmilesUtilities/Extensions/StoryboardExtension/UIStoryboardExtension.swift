//
//  UIStoryboard+Factory.swift
//  hkImperatorMensa
//
//  Copyright © 2018 Anderson Gusmao. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var homeStoryboard: UIStoryboard {
        return UIStoryboard(name: "Home_new", bundle: nil)
    }
    
    static var couponsAndVouchersStoryboard: UIStoryboard {
        return UIStoryboard(name: "CouponsAndVouchers", bundle: nil)
    }
    
    static var htmlTextViewStoryboard: UIStoryboard {
          return UIStoryboard(name: "HTMLTextView", bundle: nil)
      }
    
    static var deviceV2Storyboard: UIStoryboard {
        return  UIStoryboard(name: "DeviceShopV2", bundle: nil)
    }

    static var PaymentStatusStoryboard: UIStoryboard {
        return UIStoryboard(name: "PaymentStatus", bundle: nil)
    }
    
    static var PlayAndWinStoryboard: UIStoryboard {
        return UIStoryboard(name: "Gamification", bundle: nil)
    }
    
    static var profileStoryboard: UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
    
    static var deviceShopStoryboard: UIStoryboard {
        return UIStoryboard(name: "DeviceShop", bundle: nil)
    }
    
    static var changeMobileNumberStoryboard: UIStoryboard {
        return UIStoryboard(name: "ChangeMobileNumber", bundle: nil)
    }
    
    static var discountOfferDetailsNumberStoryboard: UIStoryboard {
        return UIStoryboard(name: "DiscountOfferDetails", bundle: nil)
    }

    
    static var oldHomeStoryboard: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }
    
    static var gamificationStoryboard: UIStoryboard {
        return UIStoryboard(name: "Gamification", bundle: nil)
    }
    
    static var checkoutPayments: UIStoryboard {
        return UIStoryboard(name: "CheckoutPayments", bundle: nil)
    }
    
    static var yallaCompareStoryBoard: UIStoryboard {
        return  UIStoryboard(name: "YallaCompare", bundle: nil)
    }
    
    static var sideMenuStoryboard: UIStoryboard {
        return UIStoryboard(name: "SideMenu", bundle: nil)
    }
    
    static var loginStoryboard: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    static var bogoStoryboard: UIStoryboard {
        return UIStoryboard(name: "BOGO", bundle: nil)
    }
    
    
    static var inAppGiftingStoryboard: UIStoryboard {
        return UIStoryboard(name: "InAppGifting", bundle: nil)
    }
    
    static var treasureChestStoryboard: UIStoryboard {
        return UIStoryboard(name: "TreasureChest", bundle: nil)
    }
    
    static var becomeAPartner: UIStoryboard {
        return UIStoryboard(name: "BecomeAPartner", bundle: nil)
    }
    
    
    static var pointExchangeStoryboard: UIStoryboard {
        return UIStoryboard(name: "PointsExchange", bundle: nil)
    }
    
    static var summaryStoryboard: UIStoryboard {
        return UIStoryboard(name: "Summary", bundle: nil)
    }
    
    static var actionSheetStoryboard: UIStoryboard {
        return UIStoryboard(name: "ActionSheet", bundle: nil)
    }
    
    static var historyStoryboard: UIStoryboard {
        return UIStoryboard(name: "History", bundle: nil)
    }
    
    static var conversionDetailStoryboard: UIStoryboard {
        return UIStoryboard(name: "ConversionDetail", bundle: nil)
    }
    
    static var pointExchangeV2Storyboard: UIStoryboard {
        return UIStoryboard(name: "PointsExchangeV2", bundle: nil)
    }
    
    static var birthDayStoryboard: UIStoryboard {
        return UIStoryboard(name: "Birthday", bundle: nil)
    }
    
    static var searchStoryboard: UIStoryboard {
        return  UIStoryboard(name: "Search", bundle: nil)
    }
    
    
    static var cbdCreditCardsStoryboard: UIStoryboard {
        return UIStoryboard(name: "CBDCreditCards", bundle: nil)
    }
    
    static var linkedAccountsStoryboard: UIStoryboard {
           return UIStoryboard(name: "LinkedAccounts", bundle: nil)
       }
    
    static var FavouritesStoryboard: UIStoryboard {
           return UIStoryboard(name: "Favourites", bundle: nil)
       }
    
    static var ChangeMobileNumberStoryboard: UIStoryboard {
           return UIStoryboard(name: "ChangeMobileNumber", bundle: nil)
       }

    static var GlobalSearchStoryboard: UIStoryboard {
           return UIStoryboard(name: "GlobalSearch", bundle: nil)
       }
    
    
    static var cbdCreditCardsRevampStoryboard: UIStoryboard {
        return UIStoryboard(name: "CBDDetailsRevamp", bundle: nil)
    }
    

    //Favourites
  
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        guard let instance = instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Oops!")
        }
        return instance
    }
    
    func instantiateController<T>(ofType type: T.Type) -> T {
        guard let instance = instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("Oops!")
        }
        return instance
    }
}



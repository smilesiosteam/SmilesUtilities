//
//  File.swift
//  
//
//  Created by Shahroze Zaheer on 27/07/2023.
//

import Foundation

public enum OfferTypes : String {
    case discount = "discount", voucher = "voucher", dealVoucher = "deal voucher", etisalat = "etisalat", NoType = "-1"
}

public enum SmilesHeaderMode: Int {
    case withoutHeader = 1
    case withHeader = 2
    case withHeaderAndParallex = 3
    case withHeaderOverlappingAndParallex = 4
    case withClearHeader = 5
    case withWhiteBackground = 6
}

public enum NavbarButton: Int, RawRepresentable {
    case menuButton
    case backButton
    case backWithBGAR
    case backWithBG
    case closeButton
    case closeBlack
    case shareBarButton
    case notificationButton
    case notificationButtonBlack
    case nearByButton
    case applyButton
    case searchButton
    case searchButtonBlack
    case playAndWinButton
    case infoBarButton
    case favouriteBarButton
    case empty
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .menuButton:
            return "menuButton"
        case .backButton:
            return "backButton"
        case .backWithBGAR:
            return "icon_BackWithBGAR"
        case .backWithBG:
            return "icon_BackWithBG"
        case .closeButton:
            return "closeButton"
        case .closeBlack:
            return "closeBlack"
        case .shareBarButton:
            return "shareImage"
        case .notificationButton:
            return "notificationButton"
        case .notificationButtonBlack:
            return "no_notification"
        case .nearByButton:
            return "nearByButton"
        case .applyButton:
            return "applyButton"
        case .searchButton:
            return "searchButton"
        case .searchButtonBlack:
            return "blackSearch"
        case .playAndWinButton:
            return "playAndWinButton"
        case .infoBarButton:
            return "infoButton"
        case .favouriteBarButton:
            return "favouritesImage"
        case .empty:
            return ""
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "menuButton":
            self = .menuButton
        case "backButton":
            self = .backButton
        case "icon_BackWithBGAR":
            self = .backWithBGAR
        case "icon_BackWithBG":
            self = .backWithBG
        case "closeButton":
            self = .closeButton
        case "closeBlack":
            self = .closeBlack
        case "shareImage":
            self = .shareBarButton
        case "notificationButton":
            self = .notificationButton
        case "no_notification":
            self = .notificationButtonBlack
        case "nearByButton":
            self = .nearByButton
        case "applyButton":
            self = .applyButton
        case "searchButton":
            self = .searchButton
        case "blackSearch":
            self = .searchButtonBlack
        case "playAndWinButton":
            self = .playAndWinButton
        case "infoButton":
            self = .infoBarButton
        case "favouritesImage":
            self = .favouriteBarButton
        default:
            return nil
        }
    }
}

public enum OSMResponseType: String {
    case json = "json"
    case jsonv2 = "jsonv2"
    case xml = "xml"
}

public enum RestaurantFiltersType : Int {
    case filters = 1, deliveryTime = 2
}

public enum FilterDictTags: String {
    case FiltersDict, FiltersForListingsDict
}

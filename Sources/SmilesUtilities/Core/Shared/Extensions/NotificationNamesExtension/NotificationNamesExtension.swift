//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 02/06/2023.
//

import Foundation

public extension Notification.Name {
    static let OfferReloadService = Notification.Name("OfferReloadService")
    static let DismissCBD = Notification.Name("dismissCBD")
    static let ReloadGetAllMembershipData = Notification.Name("ReloadGetAllMembershipData")
    static let ReloadNonMemberShipData = Notification.Name("ReloadNonMemberShipData")
    static let LocationUpdated = Notification.Name("LocationUpdated")
    static let DidGetCountriesListResponse = Notification.Name("didGetCountriesListResponse")
    static let HandleViewWillAppearForRestaurantDetail = Notification.Name("HandleViewWillAppearForRestaurantDetail")
    static let Bug1Get1Purhcased = Notification.Name("Bug1Get1Purhcased")
    static let ReloadSubHome = Notification.Name("ReloadSubscriptionsHome")
    static let PopToHomeMamba = Notification.Name("PopToHomeMamba")
    static let ReloadSpecialOffer = Notification.Name("ReloadSpecialOffer")
    static let ReloadOrderSummary = Notification.Name("ReloadOrderSummary")
}

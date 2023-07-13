//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import UIKit

public enum RestaurantOrderType: Int {
    case isDelivery
    case isPickup
    case isDeliveryAndPickup
    case none
}

public enum RestaurantStatusType: Int {
    case open
    case closed
    case willOpen
    case willClose
    case temporaryClose
    case none
}

public enum RestaurantStatusTypeForPopularRestaurants: String {
    case open = "OPEN", willopen = "WILL_OPEN", willclose = "WILL_CLOSE", tempclose = "TEMP_CLOSED", restinfo = "REST_INFO_OPEN"
}

public class Restaurant: Codable {
    public var cartDetails: CartDetails?
    public var lastOrderDetails:LastOrderDetails?
    public var subTotal: Double?
    public var restaurantDiscountAmount: Double?
    public var couponDiscountAmount: Double?
    public var couponDiscount: Double?
    public var couponSponsored: String?
    public var grandTotal: Double?
    public var isEligibleBogo: Bool?
    public var bogoDiscountAmount: Double?
    public var vatPrice: Double?
    public var totalSaving: Double?
    public var minOrderCheck: Double?
    public var nextOpeningTime: String?
    public var locationId: String?
    public var liveTracking: Bool?
    public var offerTags: String?
    public var offerDiscountText: String?
    public var ratingCount: Int?
    public var restaurantDistance: Double?
    public var deliveryCharges: Double?
    public var address: String?
    public var backgroundIcon: String?
    public var itemId: String?
    public var orderStatus: Bool?
    public var restaurantStatusColorMessage: String?
    public var restaurantMenu: [RestaurantMenu]?
    public var deliveryTip: Int?
    public var pickupTime: String?
    public var description: String?
    public var amountPerPerson: Int?
    public var closingTime: String?
    public var cuisines: [String]?
    public var deliveryTime: Int?
    public var deliveryTimeRange: String?
    public var iconUrl: String?
    public var imageUrl: String?
    public var latitude: String?
    public var location: String?
    public var longitude: String?
    public var minimumOrder: Double?
    public var openingTime: String?
    public var restaurantId: String?
    public var restaurantName: String?
    public var restaurantRating: Double?
    public var restaurantStatus: Bool?
    public var restaurantStatusMessage: String?
    public var timings: [RestaurantInfoTiming]?
    public var totalPoints: Int?
    public var isIndividualDeliver: Bool?
    public var restaurantNumber: String?
    public var isRestInfo: Bool?
    public var earnPoints: Int?
    
    public var isDelivery: Bool?
    public var isPickup: Bool?

    public var isBogo: Bool?
    public var promotionsCount: Int?
    
    public var couponId : String?
    public var couponName: String?
    public var couponDescription : String?
    public var couponTerms : String?
    public var isVirtualRestaurant: Bool?
    public var virtualRestaurantDetails: VirtualRestaurantDetails?
    public var isBogoBanner: Int?
    public var isFavoriteRestaurant : Bool?
    public var isFoodSubscription: Bool?
    public var isDeliveryFree: Bool?
    public var subscriptionBanner: SubscriptionsBanner?
    public var restaurantInfoShareText: String?
    public var isRestaurantShareBtn: Bool?
    public var tempClosed: Bool?
    public var inlineItemTotal : Double?
    public var menuItemType: String?//not part of json, used as storage
    public var restaurantStatusTypeForPopular: String?
    public var recommendationModelEvent: String?
    public var userComments:String?
    public var cookingInstruction:String?
    public var restaurantFeatures: NSAttributedString {
        return Restaurant.makeRestaurantFeaturesText(liveTracking: self.liveTracking, restaurantOrderType: self.restaurantOrderType, minimumOrder: self.minimumOrder, deliveryCharges: self.deliveryCharges, isSubscriber: self.isFoodSubscription)
    }
    //Added static function to enhance reusability at other places
    class func makeRestaurantFeaturesText(liveTracking:Bool?, restaurantOrderType:RestaurantOrderType, minimumOrder:Double?, deliveryCharges:Double?,isSubscriber:Bool?) -> NSAttributedString {
        var restaurantFeatures = [NSAttributedString]()
        if let liveTracking = liveTracking, liveTracking {
            if restaurantOrderType != .isPickup {
                let liveTrackingDesc = NSAttributedString(string: "liveTracking".localizedString)
                restaurantFeatures.append(liveTrackingDesc)
            }
        }
        
        if let minimumOrder = minimumOrder, minimumOrder > 0 {
            if restaurantOrderType != .isPickup {
                let minimumOrderDesc = NSAttributedString(string: String(format: "minOrder".localizedString, String(minimumOrder)))
                restaurantFeatures.append(minimumOrderDesc)
            }
        }
        
        var deliveryChargesDesc: NSAttributedString?
        if let deliveryCharges = deliveryCharges, deliveryCharges > 0 {
            if restaurantOrderType != .isPickup {
                if let isFoodSubscription = isSubscriber, isFoodSubscription {
                    let deliveryText = String(format: "DeliveryFeeText".localizedString, String(deliveryCharges))
                    deliveryChargesDesc = deliveryText.strikoutString(strikeOutColor: .appDarkGrayColor)
                } else {
                    deliveryChargesDesc = NSAttributedString(string: String(format: "DeliveryFeeText".localizedString, String(deliveryCharges)))
                }
            }
        }
        else {
            if restaurantOrderType != .isPickup {
                deliveryChargesDesc = NSAttributedString(string: "FreeDeliveryText".localizedString)
            }
        }
        
        restaurantFeatures.append(deliveryChargesDesc ?? NSAttributedString(string: ""))
        let value = restaurantFeatures.joined(with: " | ")
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: value)
        attributedString.setColorForText(textForAttribute: " | ", withColor: .appGreyColor_128)
        return attributedString
    }
    
    public var restaurantOrderType: RestaurantOrderType {
        let isDeliveryOnly = isDelivery.asBoolOrFalse()
        let isPickupOnly = isPickup.asBoolOrFalse()
        
        if isPickupOnly, isDeliveryOnly {
            return .isDeliveryAndPickup
        }
        else if isDeliveryOnly {
            return .isDelivery
        }
        else if isPickupOnly {
            return .isPickup
        }
        return .none
    }
    
    public var isFreeDelivery: Bool {
        if let charges = deliveryCharges, charges == 0 {
            return true
        }
        return false
    }
    
    public var minimumOrderFullText: String {
        if let minimumOrder = minimumOrder, minimumOrder > 0 {
            return "\(minimumOrder)" + "AEDTitle".localizedString
        }
        return .emptyString
    }
    
    public var amountPerPersonFullText: String {
        //Hide below as per business request
        if let amountPerPerson = amountPerPerson, amountPerPerson > 0 {
            return "\(amountPerPerson)" + "AEDTitle".localizedString
        }
        return .emptyString
    }
    
    public var restaurantStatusForPopularRestaurants: RestaurantStatusTypeForPopularRestaurants {
        
        let status =  restaurantStatusTypeForPopular.asStringOrEmpty()
        if status == "OPEN" {
            return .open
        } else if status == "WILL_OPEN" {
            return .willopen
        } else  if status == "WILL_CLOSE" {
            return .willclose
        } else if status == "TEMP_CLOSED" {
            return .tempclose
        } else if status == "REST_INFO_OPEN" {
            return .restinfo
        }
        else {
            return .open
        }
    }

    
    public var restaurantStatusType: RestaurantStatusType {
        let statusMessage = restaurantStatusMessage.asStringOrEmpty()
        let status = restaurantStatus.asBoolOrFalse()
        let tempClosed = tempClosed.asBoolOrFalse()
        
        if status, statusMessage.isEmpty {
            return .open
        }
        /**
         Handle this for restaurant Info and do not change this computed property as i will affect a lot of places
        */
        else if !status, !statusMessage.isEmpty,tempClosed{
            return .temporaryClose
        }
        else if status, !statusMessage.isEmpty {
            return .willClose
        }
        else if !status, statusMessage.isEmpty {
            return .closed
        }
        else if !status, !statusMessage.isEmpty {
            return .willOpen
        }
        else {
            return .none
        }
    }
    
    public var restaurantStatusTypeColor: UIColor {
        let status = isRestInfo.asBoolOrFalse()
        
        if status {
            return .appGreenSecondaryColor
        } else {
            return .appRedSecondaryColor
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case amountPerPerson
        case cuisines
        case deliveryTime
        case deliveryTimeRange
        case iconUrl
        case imageUrl
        case liveTracking
        case location
        case minimumOrder
        case offerTags
        case offerDiscountText
        case ratingCount
        case restaurantDistance
        case restaurantId
        case restaurantName
        case restaurantRating
        case restaurantStatus
        case deliveryCharges
        case address
        case backgroundIcon
        case isDelivery
        case isPickup
        case itemId
        case orderStatus
        case restaurantMenu
        case totalPoints
        case restaurantStatusMessage
        case locationId
        case nextOpeningTime
        case subTotal
        case restaurantDiscountAmount
        case couponDiscountAmount
        case couponDiscount
        case couponSponsored
        case grandTotal
        case vatPrice
        case totalSaving
        case minOrderCheck
        case cartDetails
        case pickupTime
        case description
        case restaurantStatusColorMessage
        case closingTime
        case latitude
        case isIndividualDeliver
        case timings
        case longitude
        case isRestInfo
        case earnPoints
        case isBogo
        case promotionsCount
        case couponId
        case couponName
        case couponDescription
        case couponTerms
        case lastOrderDetails
        case isBogoBanner
        case restaurantNumber
        case isEligibleBogo
        case bogoDiscountAmount
        case isFavoriteRestaurant
        case isFoodSubscription
        case isDeliveryFree
        case subscriptionBanner
        case isVirtualRestaurant
        case virtualRestaurantDetails
        case inlineItemTotal
        case restaurantInfoShareText
        case isRestaurantShareBtn
        case tempClosed
        case deliveryTip
        case restaurantStatusTypeForPopular = "restaurantStatusType"
        case recommendationModelEvent
        case userComments
        case cookingInstruction
    }
    
    
    public init() {}
    
    required public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            restaurantInfoShareText = try values.decodeIfPresent(String.self, forKey: .restaurantInfoShareText)
            isRestaurantShareBtn = try values.decodeIfPresent(Bool.self, forKey: .isRestaurantShareBtn)
            lastOrderDetails = try values.decodeIfPresent(LastOrderDetails.self, forKey: .lastOrderDetails)
            cartDetails = try values.decodeIfPresent(CartDetails.self, forKey: .cartDetails)
            address = try values.decodeIfPresent(String.self, forKey: .address)
            backgroundIcon = try values.decodeIfPresent(String.self, forKey: .backgroundIcon)
            isDelivery = try values.decodeIfPresent(Bool.self, forKey: .isDelivery)
            isPickup = try values.decodeIfPresent(Bool.self, forKey: .isPickup)
            itemId = try values.decodeIfPresent(String.self, forKey: .itemId)
            orderStatus = try values.decodeIfPresent(Bool.self, forKey: .orderStatus)
            restaurantMenu = try values.decodeIfPresent([RestaurantMenu].self, forKey: .restaurantMenu)
            amountPerPerson = 0//try values.decodeIfPresent(Int.self, forKey: .amountPerPerson)
            cuisines = try values.decodeIfPresent([String].self, forKey: .cuisines)
            deliveryTime = try values.decodeIfPresent(Int.self, forKey: .deliveryTime)
            deliveryTimeRange = try values.decodeIfPresent(String.self, forKey: .deliveryTimeRange)
            iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
            imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
            liveTracking = try values.decodeIfPresent(Bool.self, forKey: .liveTracking)
            location = try values.decodeIfPresent(String.self, forKey: .location)
            deliveryCharges = try values.decodeIfPresent(Double.self, forKey: .deliveryCharges)
            minimumOrder = try values.decodeIfPresent(Double.self, forKey: .minimumOrder)
            offerTags = try values.decodeIfPresent(String.self, forKey: .offerTags)
            offerDiscountText = try values.decodeIfPresent(String.self, forKey: .offerDiscountText)
            ratingCount = try values.decodeIfPresent(Int.self, forKey: .ratingCount)
            restaurantDistance = try values.decodeIfPresent(Double.self, forKey: .restaurantDistance)
            restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
            restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
            restaurantRating = try values.decodeIfPresent(Double.self, forKey: .restaurantRating)
            restaurantStatus = try values.decodeIfPresent(Bool.self, forKey: .restaurantStatus)
            totalPoints = try values.decodeIfPresent(Int.self, forKey: .totalPoints)
            restaurantStatusMessage = try values.decodeIfPresent(String.self, forKey: .restaurantStatusMessage)
            locationId = try values.decodeIfPresent(String.self, forKey: .locationId)
            nextOpeningTime = try values.decodeIfPresent(String.self, forKey: .nextOpeningTime)
            subTotal = try values.decodeIfPresent(Double.self, forKey: .subTotal)
            restaurantDiscountAmount = try values.decodeIfPresent(Double.self, forKey: .restaurantDiscountAmount)
            couponDiscountAmount = try values.decodeIfPresent(Double.self, forKey: .couponDiscountAmount)
            couponDiscount = try values.decodeIfPresent(Double.self, forKey: .couponDiscount)
            couponSponsored = try values.decodeIfPresent(String.self, forKey: .couponSponsored)
            grandTotal = try values.decodeIfPresent(Double.self, forKey: .grandTotal)
            vatPrice = try values.decodeIfPresent(Double.self, forKey: .vatPrice)
            totalSaving = try values.decodeIfPresent(Double.self, forKey: .totalSaving)
            minOrderCheck = try values.decodeIfPresent(Double.self, forKey: .minOrderCheck)
            isIndividualDeliver = try values.decodeIfPresent(Bool.self, forKey: .isIndividualDeliver)
            
            timings = try values.decodeIfPresent([RestaurantInfoTiming].self, forKey: .timings)
            longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
            pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
            description = try values.decodeIfPresent(String.self, forKey: .description)
            restaurantStatusColorMessage = try values.decodeIfPresent(String.self, forKey: .restaurantStatusColorMessage)
            closingTime = try values.decodeIfPresent(String.self, forKey: .closingTime)

            latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
            isRestInfo = try values.decodeIfPresent(Bool.self, forKey: .isRestInfo)
            earnPoints = try values.decodeIfPresent(Int.self, forKey: .earnPoints)
            isBogo = try values.decodeIfPresent(Bool.self, forKey: .isBogo)
            promotionsCount = try values.decodeIfPresent(Int.self, forKey: .promotionsCount)
            
            couponId = try values.decodeIfPresent(String.self, forKey: .couponId)
            couponName = try values.decodeIfPresent(String.self, forKey: .couponName)
            couponDescription = try values.decodeIfPresent(String.self, forKey: .couponDescription)
            couponTerms = try values.decodeIfPresent(String.self, forKey: .couponTerms)
            
            isBogoBanner = try values.decodeIfPresent(Int.self, forKey: .isBogoBanner)
            restaurantNumber = try values.decodeIfPresent(String.self, forKey: .restaurantNumber)
            
            isEligibleBogo = try values.decodeIfPresent(Bool.self, forKey: .isEligibleBogo)
            bogoDiscountAmount = try values.decodeIfPresent(Double.self, forKey: .bogoDiscountAmount)
            isFavoriteRestaurant = try values.decodeIfPresent(Bool.self, forKey: .isFavoriteRestaurant)
            isFoodSubscription = try values.decodeIfPresent(Bool.self, forKey: .isFoodSubscription)
            isDeliveryFree = try values.decodeIfPresent(Bool.self, forKey: .isDeliveryFree)
            subscriptionBanner = try values.decodeIfPresent(SubscriptionsBanner.self, forKey: .subscriptionBanner)
            isVirtualRestaurant = try values.decodeIfPresent(Bool.self, forKey: .isVirtualRestaurant)
            virtualRestaurantDetails = try values.decodeIfPresent(VirtualRestaurantDetails.self, forKey: .virtualRestaurantDetails)
            
            inlineItemTotal = try values.decodeIfPresent(Double.self, forKey: .inlineItemTotal)
            tempClosed = try values.decodeIfPresent(Bool.self, forKey: .tempClosed)
            deliveryTip = try values.decodeIfPresent(Int.self, forKey: .deliveryTip)
            restaurantStatusTypeForPopular = try values.decodeIfPresent(String.self, forKey: .restaurantStatusTypeForPopular)
            recommendationModelEvent = try values.decodeIfPresent(String.self, forKey: .recommendationModelEvent)
            userComments = try values.decodeIfPresent(String.self, forKey: .userComments)
            cookingInstruction = try values.decodeIfPresent(String.self, forKey: .cookingInstruction)
        }
        catch {
            print(error)
        }
    }
}


public struct LastOrderDetails: Codable {
    
    public var orderNumber: String?
    public var restaurantName : String?
    public var totalAmount : String?
    public var orderId : Int?
    public var items :Int?
    public var orderDate:String?

    enum CodingKeys: String, CodingKey {
        case orderNumber
        case restaurantName
        case totalAmount
        case orderId
        case items
        case orderDate
    }
    
    public init() {
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
            restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
            totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
            orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
            items = try values.decodeIfPresent(Int.self, forKey: .items)
            orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
        } catch {
            print(error)
        }
    }
}


public struct VirtualRestaurantDetails: Codable {
    
    public var addressTitle: String?
    public var addressDescription : String?
    public var addressIconUrl : String?
    public var partnerTitle : String?
    public var partnerSubTitle :String?
    public var partnerImageURL:String?
    public var partnerRedirectionURL:String?
    public var termsAndCondition:[String]?
    public var instructionText: String?
    public var buttonText : String?
    public var title : String?
    public var subTitle : String?
    public var isVatable : Bool?
    public var vatDescription : String?
    public var restaurantId : String?
    public var virtualRestaurantId : String?
    public var addressCartTitle: String?
    public var addressCartDescription: String?
    public var addressCartIconUrl: String?


    enum CodingKeys: String, CodingKey {
        case addressTitle
        case addressDescription
        case addressIconUrl
        case partnerTitle
        case partnerSubTitle
        case partnerImageURL
        case partnerRedirectionURL
        case termsAndCondition
        case instructionText
        case buttonText
        case title
        case subTitle
        case isVatable
        case vatDescription
        case restaurantId
        case virtualRestaurantId
        case addressCartTitle
        case addressCartDescription
        case addressCartIconUrl
    }
    
    public init() {
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            addressTitle = try values.decodeIfPresent(String.self, forKey: .addressTitle)
            addressDescription = try values.decodeIfPresent(String.self, forKey: .addressDescription)
            addressIconUrl = try values.decodeIfPresent(String.self, forKey: .addressIconUrl)
            partnerTitle = try values.decodeIfPresent(String.self, forKey: .partnerTitle)
            partnerSubTitle = try values.decodeIfPresent(String.self, forKey: .partnerSubTitle)
            partnerImageURL = try values.decodeIfPresent(String.self, forKey: .partnerImageURL)
            partnerRedirectionURL = try values.decodeIfPresent(String.self, forKey: .partnerRedirectionURL)
            termsAndCondition = try values.decodeIfPresent([String].self, forKey: .termsAndCondition)
            instructionText = try values.decodeIfPresent(String.self, forKey: .instructionText)
            buttonText = try values.decodeIfPresent(String.self, forKey: .buttonText)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            subTitle = try values.decodeIfPresent(String.self, forKey: .subTitle)
            isVatable = try values.decodeIfPresent(Bool.self, forKey: .isVatable)
            vatDescription = try values.decodeIfPresent(String.self, forKey: .vatDescription)
            restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
            virtualRestaurantId = try values.decodeIfPresent(String.self, forKey: .virtualRestaurantId)
            addressCartTitle = try values.decodeIfPresent(String.self, forKey: .addressCartTitle)
            addressCartDescription = try values.decodeIfPresent(String.self, forKey: .addressCartDescription)
            addressCartIconUrl = try values.decodeIfPresent(String.self, forKey: .addressCartIconUrl)

        } catch {
            print(error)
        }
    }
}

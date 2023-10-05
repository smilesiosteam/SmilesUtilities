//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 03/07/2023.
//

import Foundation

public class BOGODetailsResponseLifestyleOffer: Codable {
    public let discountedPrice: Double?
    public let catalogImageUrl: String?
    public let whatYouMissTitle: String?
    public let priceBeforeDiscount: Int?
    public let disclaimerText: String?
    public let whatYouMissTextList: [String?]
    public let autoRenewable: Bool?
    public let duration: Int?
    public let expiry: String?
    public let expiryDate: String?
    public let nextRenewalDate: String?
    public let freeBannerText: String?
    public let freeBogoOffer: Bool?
    public var freeBogoOfferText: String?
    public let fullDuration: String?
    public let isSubscription: Bool?
    public let offerId: String?
    public let partnerPointRate: Int?
    public var price: Double?
    public let whatYouGetText: String?
    public let whatYouGetTitle: String?
    public let paymentMethods: [PaymentMethod]?
    public let monthlyPrice: String?
    public var percentageValue: String? = ""
    public var discountedPrice: Int?
    public let linkedOffer: String? = ""
    public let offerDescription: String?
    public let offerTitle: String?
    public let pointsValue: Int?
    public let subscriptionSegment: String?
    public let termsAndConditions: String?
    public let subscriptionId: String?
    public let lifeStyleLinkedOffer: BOGODetailsResponseLifeStyleLinkedOffer?
    public let whatYouGetTextList: [String]?
    public var paymentDetails: PaymentMethod?
    public let subscriptionChannel: String?
    public let subscriptionStatus : String?
    public let subscriptionStatusText : String?
    public let subscribedSegment : String?
    public let subscribedOfferTitle: String?
    public let subscribeImage: String?
    public let freeDuration: Int?
    public let subscriptionAccountNumber: String?
    public let coBrandFlag: Bool?
    public let coBrandText: String?
    public let monthlyPriceCost: String?
    public let redirectionUrl: String?
    public let subscriptionSavings: Double?
    public let subscriptionSavingsFactor: Int?
    public let benefits: [WhatYouGet]?

    enum CodingKeys: String, CodingKey {
        
        case catalogImageUrl
        case whatYouMissTitle
        case whatYouMissTextList
        case disclaimerText
        case priceBeforeDiscount
        case discountedPrice
        case autoRenewable
        case duration
        case expiry
        case expiryDate
        case nextRenewalDate
        case freeBannerText
        case freeBogoOffer
        case fullDuration
        case isSubscription
        case offerId
        case partnerPointRate
        case price
        case whatYouGetText
        case whatYouGetTitle
        case paymentMethods
        case discountedPrice
        case percentageValue
        case monthlyPrice
        case linkedOffer
        case offerDescription
        case offerTitle
        case pointsValue
        case subscriptionSegment
        case termsAndConditions
        case subscriptionId
        case lifeStyleLinkedOffer
        case freeBogoOfferText
        case whatYouGetTextList
        case paymentDetails
        case subscriptionChannel
        case subscriptionStatus
        case subscriptionStatusText
        case subscribedSegment
        case subscribedOfferTitle
        case subscribeImage
        case freeDuration
        case subscriptionAccountNumber
        case coBrandFlag
        case coBrandText
        case monthlyPriceCost
        case redirectionUrl
        case subscriptionSavings
        case subscriptionSavingsFactor
        case benefits = "whatYouGet"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        discountedPrice = try values.decodeIfPresent(Double.self, forKey: .discountedPrice)
        catalogImageUrl = try values.decodeIfPresent(String.self, forKey: .catalogImageUrl)
        whatYouMissTitle = try values.decodeIfPresent(String.self, forKey: .whatYouMissTitle)
        whatYouMissTextList = try values.decodeIfPresent([String?].self, forKey: .whatYouMissTextList) ?? []
        disclaimerText = try values.decodeIfPresent(String.self, forKey: .disclaimerText)
        priceBeforeDiscount = try values.decodeIfPresent(Int.self, forKey: .priceBeforeDiscount)
        
        
        autoRenewable = try values.decodeIfPresent(Bool.self, forKey: .autoRenewable)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        expiry = try values.decodeIfPresent(String.self, forKey: .expiry)
        expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
        nextRenewalDate = try values.decodeIfPresent(String.self, forKey: .nextRenewalDate)
        freeBannerText = try values.decodeIfPresent(String.self, forKey: .freeBannerText)
        freeBogoOffer = try values.decodeIfPresent(Bool.self, forKey: .freeBogoOffer)
        fullDuration = try values.decodeIfPresent(String.self, forKey: .fullDuration)
        isSubscription = try values.decodeIfPresent(Bool.self, forKey: .isSubscription)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        partnerPointRate = try values.decodeIfPresent(Int.self, forKey: .partnerPointRate)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        whatYouGetText = try values.decodeIfPresent(String.self, forKey: .whatYouGetText)
        whatYouGetTitle = try values.decodeIfPresent(String.self, forKey: .whatYouGetTitle)
        paymentMethods = try values.decodeIfPresent([PaymentMethod].self, forKey: .paymentMethods)
        discountedPrice = try values.decodeIfPresent(Int.self, forKey: .discountedPrice)
        percentageValue = try values.decodeIfPresent(String.self, forKey: .percentageValue)
        monthlyPrice = try values.decodeIfPresent(String.self, forKey: .monthlyPrice)
        offerDescription = try values.decodeIfPresent(String.self, forKey: .offerDescription)
        offerTitle = try values.decodeIfPresent(String.self, forKey: .offerTitle)
        pointsValue = try values.decodeIfPresent(Int.self, forKey: .pointsValue)
        subscriptionSegment = try values.decodeIfPresent(String.self, forKey: .subscriptionSegment)
        termsAndConditions = try values.decodeIfPresent(String.self, forKey: .termsAndConditions)
        subscriptionId = try values.decodeIfPresent(String.self, forKey: .subscriptionId)

        lifeStyleLinkedOffer = try values.decodeIfPresent(BOGODetailsResponseLifeStyleLinkedOffer.self, forKey: .lifeStyleLinkedOffer)
        freeBogoOfferText = try values.decodeIfPresent(String.self, forKey: .freeBogoOfferText)
        whatYouGetTextList = try values.decodeIfPresent([String].self, forKey: .whatYouGetTextList)

        paymentDetails = try values.decodeIfPresent(PaymentMethod.self, forKey: .paymentDetails)
        subscriptionChannel = try values.decodeIfPresent(String.self, forKey: .subscriptionChannel)
        subscriptionStatus = try values.decodeIfPresent(String.self, forKey: .subscriptionStatus)
        subscriptionStatusText = try values.decodeIfPresent(String.self, forKey: .subscriptionStatusText)
        
        subscribedSegment = try values.decodeIfPresent(String.self, forKey: .subscribedSegment)
        subscribedOfferTitle = try values.decodeIfPresent(String.self, forKey: .subscribedOfferTitle)
        subscribeImage = try values.decodeIfPresent(String.self, forKey: .subscribeImage)
        freeDuration = try values.decodeIfPresent(Int.self, forKey: .freeDuration)
        subscriptionAccountNumber = try values.decodeIfPresent(String.self, forKey: .subscriptionAccountNumber)
        coBrandFlag = try values.decodeIfPresent(Bool.self, forKey: .coBrandFlag)
        coBrandText = try values.decodeIfPresent(String.self, forKey: .coBrandText)
        monthlyPriceCost = try values.decodeIfPresent(String.self, forKey: .monthlyPriceCost)
        redirectionUrl = try values.decodeIfPresent(String.self, forKey: .redirectionUrl)
        subscriptionSavings = try values.decodeIfPresent(Double.self, forKey: .subscriptionSavings)
        subscriptionSavingsFactor = try values.decodeIfPresent(Int.self, forKey: .subscriptionSavingsFactor)
        benefits = try values.decodeIfPresent([WhatYouGet].self, forKey: .benefits)
    }

    public func asDictionary() -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded
    }

    public func getOfferPrice() -> String {
        if AppCommonMethods.languageIsArabic() {
            return "\(String(price ?? 0)) \("AED".localizedString)"
        } else {
            return "\("AED".localizedString) \(String(price ?? 0))"
        }
    }
}

public class WhatYouGet: Codable {
    
    public let text: String?
    public let iconURL: String?

    enum CodingKeys: String, CodingKey {
        case text
        case iconURL = "iconUrl"
    }

    init(text: String, iconURL: String) {
        self.text = text
        self.iconURL = iconURL
    }
    
}

/* NEW model for partner cusines title*/

public class BOGODetailsResponseLifeStyleLinkedOffer: Codable {
    public let descriptionField: String?
    public let offerDetails: [BOGODetailsResponseOfferDetail]?
    public let isPromoCodeAllow: Bool?
    public let title: String?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case offerDetails
        case title
        case isPromoCodeAllow
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        offerDetails = try values.decodeIfPresent([BOGODetailsResponseOfferDetail].self, forKey: .offerDetails)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        isPromoCodeAllow = try values.decodeIfPresent(Bool.self, forKey: .isPromoCodeAllow)
    }
}

/* NEW model for partners and cusines*/

public class BOGODetailsResponseOfferDetail: Codable {
    public let descriptionField: String?
    public let partnerImageUrl: String?
    public let partnerTitle: String?
    public let redirectionUrl: String?
    public let title: String?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case partnerImageUrl
        case partnerTitle
        case redirectionUrl
        case title
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        partnerImageUrl = try values.decodeIfPresent(String.self, forKey: .partnerImageUrl)
        partnerTitle = try values.decodeIfPresent(String.self, forKey: .partnerTitle)
        redirectionUrl = try values.decodeIfPresent(String.self, forKey: .redirectionUrl)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

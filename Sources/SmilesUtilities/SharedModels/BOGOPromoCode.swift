//
//  PromoCode.swift
//  House
//
//  Created by Usman Tarar on 14/04/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit

public class BOGOPromoCode : NSObject, Codable {
    
    public var consumedCounter: Int?
    public var createdDate: String?
    public var duration: String?
    public var endDate: String?
    public var offerId: String?
    public var promoCode: String?
    public var promoCodeType: Int?
    public var promoType: Int?
    public var redeemed: Bool?
    public var redemptionCounter: Int?
    public var startDate: String?
    public var value: Double?
    public var freeBogoOfferText: String?
    public var descriptionText: String?
    
    enum CodingKeys: String, CodingKey {
        case consumedCounter
        case createdDate
        case duration
        case endDate
        case offerId
        case promoCode
        case promoCodeType
        case promoType
        case redeemed
        case redemptionCounter
        case startDate
        case value
        case freeBogoOfferText
        case descriptionText
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        consumedCounter = try values.decodeIfPresent(Int.self, forKey: .consumedCounter)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        promoCode = try values.decodeIfPresent(String.self, forKey: .promoCode)
        promoCodeType = try values.decodeIfPresent(Int.self, forKey: .promoCodeType)
        promoType = try values.decodeIfPresent(Int.self, forKey: .promoType)
        redeemed = try values.decodeIfPresent(Bool.self, forKey: .redeemed)
        redemptionCounter = try values.decodeIfPresent(Int.self, forKey: .redemptionCounter)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        freeBogoOfferText = try values.decodeIfPresent(String.self, forKey: .freeBogoOfferText)
        descriptionText = try values.decodeIfPresent(String.self, forKey: .descriptionText)
    }
    
    override init(){}
    
    init(fromDictionary dictionary: [AnyHashable: Any]) {
        consumedCounter = dictionary["consumedCounter"] as? Int
        createdDate = dictionary["createdDate"] as? String
        duration = dictionary["duration"] as? String
        endDate = dictionary["endDate"] as? String
        offerId = dictionary["offerId"] as? String
        promoCode = dictionary["promoCode"] as? String
        promoCodeType = dictionary["promoCodeType"] as? Int
        promoType = dictionary["promoType"] as? Int
        redeemed = dictionary["redeemed"] as? Bool
        redemptionCounter = dictionary["redemptionCounter"] as? Int
        startDate = dictionary["startDate"] as? String
        value = dictionary["value"] as? Double
        freeBogoOfferText = dictionary["freeBogoOfferText"] as? String
        descriptionText = dictionary["description"] as? String
    }
    
}

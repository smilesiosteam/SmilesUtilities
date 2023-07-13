//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct SubscriptionsBanner: Codable {
    public var subscriptionTitle: String?
    public var subscriptionDescription: String?
    public var subscriptionIcon: String?
    public var freeDeliveryText: String?
    public var redirectionUrl: String?
    public var subscriptionImage: String?
    
    enum CodingKeys: String, CodingKey {
        case subscriptionTitle
        case subscriptionDescription
        case subscriptionIcon
        case freeDeliveryText
        case redirectionUrl
        case subscriptionImage
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subscriptionTitle = try values.decodeIfPresent(String.self, forKey: .subscriptionTitle)
        subscriptionDescription = try values.decodeIfPresent(String.self, forKey: .subscriptionDescription)
        subscriptionIcon = try values.decodeIfPresent(String.self, forKey: .subscriptionIcon)
        freeDeliveryText = try values.decodeIfPresent(String.self, forKey: .freeDeliveryText)
        redirectionUrl = try values.decodeIfPresent(String.self, forKey: .redirectionUrl)
        subscriptionImage = try values.decodeIfPresent(String.self, forKey: .subscriptionImage)
    }
}

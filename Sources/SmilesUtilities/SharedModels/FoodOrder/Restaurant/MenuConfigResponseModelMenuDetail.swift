//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct MenuConfigResponseModelMenuDetail : Codable {
    
    public let itemDescription : String?
    public let itemId : String?
    public let itemName : String?
    public let location : String?
    public let restaurantId : String?
    public let restaurantName : String?
    
    enum CodingKeys: String, CodingKey {
        case itemDescription = "itemDescription"
        case itemId = "itemId"
        case itemName = "itemName"
        case location = "location"
        case restaurantId = "restaurantId"
        case restaurantName = "restaurantName"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemDescription = try values.decodeIfPresent(String.self, forKey: .itemDescription)
        itemId = try values.decodeIfPresent(String.self, forKey: .itemId)
        itemName = try values.decodeIfPresent(String.self, forKey: .itemName)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
        restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
    }
    
}

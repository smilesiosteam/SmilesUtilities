//
//  RestaurantResponse.swift
//  House
//
//  Created by Usman Tarar on 13/08/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit

public class RestaurantRequest: Codable {
    public var userInfo: AppUserInfo?
    public var pageNo: Int?
    public var menuItemType: String?
    public var filters : [RestaurantRequestFilter]?
    public var operationName : String?
    public var isGuestUser: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userInfo
        case pageNo
        case menuItemType
        case filters
        case operationName
        case isGuestUser
    }
    
    public init() {}

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userInfo = try values.decodeIfPresent(AppUserInfo.self, forKey: .userInfo)
        pageNo = try values.decodeIfPresent(Int.self, forKey: .pageNo)
        menuItemType = try values.decodeIfPresent(String.self, forKey: .menuItemType)
        filters = try values.decodeIfPresent([RestaurantRequestFilter].self, forKey: .filters)
        operationName = try values.decodeIfPresent(String.self, forKey: .operationName)
        isGuestUser = try values.decodeIfPresent(Bool.self, forKey: .isGuestUser)
    }
    
    public func asDictionary(dictionary: [String: Any]) -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary: dictionary)
    }
}


public class RestaurantRequestFilter : Codable {
    
    public var filterKey : String?
    public var filterValue : String?
    
    enum CodingKeys: String, CodingKey {
        case filterKey = "filterKey"
        case filterValue = "filterValue"
    }
    
    public init() {}
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filterKey = try values.decodeIfPresent(String.self, forKey: .filterKey)
        filterValue = try values.decodeIfPresent(String.self, forKey: .filterValue)
    }
    
}


public class RestaurantRequestWithNameFilter : Codable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        
    }
    
    public static func == (lhs: RestaurantRequestWithNameFilter, rhs: RestaurantRequestWithNameFilter) -> Bool {
        return lhs.filterName?.lowercased() == rhs.filterName?.lowercased()
    }
    
    
    public var filterKey : String?
    public var filterValue : String?
    public var filterName : String?
    public var indexPath: IndexPath?
    
    enum CodingKeys: String, CodingKey {
        case filterKey = "filterKey"
        case filterValue = "filterValue"
        case filterName = "filterName"
    }
    
    public init() {}
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filterKey = try values.decodeIfPresent(String.self, forKey: .filterKey)
        filterValue = try values.decodeIfPresent(String.self, forKey: .filterValue)
        filterName = try values.decodeIfPresent(String.self, forKey: .filterName)
    }
    
}


public class RemoveCartRequest: Codable {
    public var userInfo: AppUserInfo?
    public var restaurantId: String?

    enum CodingKeys: String, CodingKey {
        case userInfo
        case restaurantId
    }
    
    public init() {}

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userInfo = try values.decodeIfPresent(AppUserInfo.self, forKey: .userInfo)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
    }
    
    public func asDictionary(dictionary: [String: Any]) -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary: dictionary)
    }
}


public class SubscriptionBannerRequest: Codable {
    public var userInfo: AppUserInfo?
    public var menuItemType: String?

    enum CodingKeys: String, CodingKey {
        case userInfo
        case menuItemType
    }
    
    public init() {}
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userInfo = try values.decodeIfPresent(AppUserInfo.self, forKey: .userInfo)
        menuItemType = try values.decodeIfPresent(String.self, forKey: .menuItemType)
    }
    
    public func asDictionary(dictionary: [String: Any]) -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary: dictionary)
    }
}

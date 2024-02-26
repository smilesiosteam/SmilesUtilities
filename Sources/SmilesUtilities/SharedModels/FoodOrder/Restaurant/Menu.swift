//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public class Menu: NSObject, Codable {
    
    public var actualPrice: Double?
    public var cartQuantity: Int?
    public var cuisines: String?
    public var discountPoints: Int?
    public var discountPrice: Double?
    public var imageUrl: String?
    public var iconUrl: String?
    public var isDiary: Bool?
    public var isEggIncluded: Bool?
    public var isFreeGluten: Bool?
    public var isHealthy: Bool?
    public var isItemAvailable: Bool?
    public var isNonVeg: Bool?
    public var isNutsIncluded: Bool?
    public var isOrganic: Bool?
    public var isSpicy: Bool?
    public var isExclusiveItem: Bool?
    public var exclusiveItemDescription: String?
    public var isVeg: Bool?
    public var isVegan: Bool?
    public var itemDescription: String?
    public var itemId: String?
    public var itemName: String?
    public var saveAmount: Double?
    public var minLimit: Int?
    public var maxLimit: Int?
    public var itemRating: Double?
    public var itemRatingCount: Int?
     
    public var isDescExpanded: Bool = false
    public var addReadLess: Bool = false
    
    public var isBogo:Bool?
    public var itemCategory: String?
    public var isFirstObject:Bool?
    public var isImageEnlarged:Bool?

    public var foodTypeImage: String {
        if let eggIncluded = isEggIncluded, eggIncluded {
            return "eggDot"
        }
        else if let veg = isVeg, veg {
            return "vegDot"
        }
        else if let nonVeg = isNonVeg, nonVeg {
            return "nonVegDot"
        }
        else {
            return ""
        }
    }
    
    public var foodActualPriceFullText: String? {
        if let price = actualPrice, price > 0 {
            return "AED".localizedString + "\(price)"
        }
        return .emptyString
    }
    
    public var pointsFullText: String {
        if let points = discountPoints, points > 0 {
            return "ORTitle".localizedString.lowercased() + " \(points) " + "PTS".localizedString
        }
        return .emptyString
    }
    
    public var priceFullText: String {
        if let price = discountPrice, price > 0 {
            return "AED".localizedString + " \(price) "
        }
        return .emptyString
    }
    
    public var foodItemType: String {
        if let spicy = isSpicy, spicy {
            return "spicy".localizedString
        }
        else if let organic = isOrganic, organic {
            return "organic".localizedString
        }
        else if let freeGluten = isFreeGluten, freeGluten {
            return "freeGluten".localizedString
        }
        else if let diary = isDiary, diary {
            return "diary".localizedString
        }
        return .emptyString
    }
    
    enum CodingKeys: String, CodingKey {
        case actualPrice
        case cartQuantity
        case cuisines
        case discountPoints
        case discountPrice
        case imageUrl
        case isDiary
        case isEggIncluded
        case isFreeGluten
        case isHealthy
        case isItemAvailable
        case isNonVeg
        case isNutsIncluded
        case isOrganic
        case isSpicy
        case isVeg
        case isVegan
        case itemDescription
        case itemId
        case itemName
        case saveAmount
        case iconUrl
        case isBogo
        case itemCategory
        case minLimit
        case maxLimit
        case itemRating
        case itemRatingCount
        case exclusiveItemDescription
        case isExclusiveItem
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actualPrice = try values.decodeIfPresent(Double.self, forKey: .actualPrice)
        cartQuantity = try values.decodeIfPresent(Int.self, forKey: .cartQuantity)
        cuisines = try values.decodeIfPresent(String.self, forKey: .cuisines)
        discountPoints = try values.decodeIfPresent(Int.self, forKey: .discountPoints)
        discountPrice = try values.decodeIfPresent(Double.self, forKey: .discountPrice)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        isDiary = try values.decodeIfPresent(Bool.self, forKey: .isDiary)
        isEggIncluded = try values.decodeIfPresent(Bool.self, forKey: .isEggIncluded)
        isFreeGluten = try values.decodeIfPresent(Bool.self, forKey: .isFreeGluten)
        isHealthy = try values.decodeIfPresent(Bool.self, forKey: .isHealthy)
        isItemAvailable = try values.decodeIfPresent(Bool.self, forKey: .isItemAvailable)
        isNonVeg = try values.decodeIfPresent(Bool.self, forKey: .isNonVeg)
        isNutsIncluded = try values.decodeIfPresent(Bool.self, forKey: .isNutsIncluded)
        isOrganic = try values.decodeIfPresent(Bool.self, forKey: .isOrganic)
        isSpicy = try values.decodeIfPresent(Bool.self, forKey: .isSpicy)
        isVeg = try values.decodeIfPresent(Bool.self, forKey: .isVeg)
        isVegan = try values.decodeIfPresent(Bool.self, forKey: .isVegan)
        itemDescription = try values.decodeIfPresent(String.self, forKey: .itemDescription)
        itemId = try values.decodeIfPresent(String.self, forKey: .itemId)
        itemName = try values.decodeIfPresent(String.self, forKey: .itemName)
        saveAmount = try values.decodeIfPresent(Double.self, forKey: .saveAmount)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
        isBogo = try values.decodeIfPresent(Bool.self, forKey: .isBogo)
        itemCategory = try values.decodeIfPresent(String.self, forKey: .itemCategory)
        minLimit = try values.decodeIfPresent(Int.self, forKey: .minLimit)
        maxLimit = try values.decodeIfPresent(Int.self, forKey: .maxLimit)
        itemRating = try values.decodeIfPresent(Double.self, forKey: .itemRating)
        itemRatingCount = try values.decodeIfPresent(Int.self, forKey: .itemRatingCount)
        isExclusiveItem = try values.decodeIfPresent(Bool.self, forKey: .isExclusiveItem)
        exclusiveItemDescription = try values.decodeIfPresent(String.self, forKey: .exclusiveItemDescription)
    }
}

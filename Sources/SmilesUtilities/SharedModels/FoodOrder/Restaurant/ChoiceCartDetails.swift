//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public class ChoiceCartDetails : Codable {
    public var cartId : String?
    public var choiceName : String?
    public var quantity : Int?
    public var choicePrice : Double?
    public var actualChoicePrice : Double?
    public var totalActualPrice : Double?
    public var restaurantId : String?
    public var discountPrice : Double?
    public var saveAmount : Double?
    public var actualChoicePoints : Double?
    public var isVeg : Bool?
    public var isEggIncluded : Bool?
    public var isNonVeg : Bool?
    public var cookingInstruction : String?
    public var choicesName : [String]?
    public var choiceIds : [String]?
    public var itemId : String?
    public var minLimit: String?
    public var maxLimit: String?
    public var isBucketDiscountExcluded: Bool?
    public var isAvailable: Bool?
    public var isExclusiveItem: Bool?
    public var exclusiveItemDescription: String?
    public var isPromoCodeExcluded: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case cartId = "cartId"
        case choiceName = "choiceName"
        case quantity = "quantity"
        case choicePrice = "choicePrice"
        case actualChoicePrice = "actualChoicePrice"
        case totalActualPrice = "totalActualPrice"
        case restaurantId = "restaurantId"
        case discountPrice = "discountPrice"
        case saveAmount = "saveAmount"
        case actualChoicePoints = "actualChoicePoints"
        case isVeg = "isVeg"
        case isEggIncluded = "isEggIncluded"
        case isNonVeg = "isNonVeg"
        case cookingInstruction = "cookingInstruction"
        case choicesName = "choicesName"
        case choiceIds = "choiceIds"
        case itemId = "itemId"
        case minLimit
        case maxLimit
        case isBucketDiscountExcluded
        case isAvailable
        case isExclusiveItem
        case exclusiveItemDescription
        case isPromoCodeExcluded
    }
    
    public init(){}
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cartId = try values.decodeIfPresent(String.self, forKey: .cartId)
        choiceName = try values.decodeIfPresent(String.self, forKey: .choiceName)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        choicePrice = try values.decodeIfPresent(Double.self, forKey: .choicePrice)
        actualChoicePrice = try values.decodeIfPresent(Double.self, forKey: .actualChoicePrice)
        totalActualPrice = try values.decodeIfPresent(Double.self, forKey: .totalActualPrice)
        restaurantId = try values.decodeIfPresent(String.self, forKey: .restaurantId)
        discountPrice = try values.decodeIfPresent(Double.self, forKey: .discountPrice)
        saveAmount = try values.decodeIfPresent(Double.self, forKey: .saveAmount)
        actualChoicePoints = try values.decodeIfPresent(Double.self, forKey: .actualChoicePoints)
        isVeg = try values.decodeIfPresent(Bool.self, forKey: .isVeg)
        isEggIncluded = try values.decodeIfPresent(Bool.self, forKey: .isEggIncluded)
        isNonVeg = try values.decodeIfPresent(Bool.self, forKey: .isNonVeg)
        cookingInstruction = try values.decodeIfPresent(String.self, forKey: .cookingInstruction)
        choicesName = try values.decodeIfPresent([String].self, forKey: .choicesName)
        choiceIds = try values.decodeIfPresent([String].self, forKey: .choiceIds)
        itemId = try values.decodeIfPresent(String.self, forKey: .itemId)
        minLimit = try values.decodeIfPresent(String.self, forKey: .minLimit)
        maxLimit = try values.decodeIfPresent(String.self, forKey: .maxLimit)
        isBucketDiscountExcluded = try values.decodeIfPresent(Bool.self, forKey: .isBucketDiscountExcluded)
        isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
        isExclusiveItem = try values.decodeIfPresent(Bool.self, forKey: .isExclusiveItem)
        exclusiveItemDescription = try values.decodeIfPresent(String.self, forKey: .exclusiveItemDescription)
        isPromoCodeExcluded = try values.decodeIfPresent(Bool.self, forKey: .isPromoCodeExcluded)
    }
    
}

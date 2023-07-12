//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct InlineItemDetails : Codable {
    public let cartId : String?
    public let choiceName : String?
    public let quantity : Int?
    public let choicePrice : Double?
    public let actualChoicePrice : Double?
    public let totalActualPrice : Double?
    public let restaurantId : String?
    public let discountPrice : Double?
    public let saveAmount : Double?
    public let actualChoicePoints : Double?
    public let isVeg : Bool?
    public let isEggIncluded : Bool?
    public let isNonVeg : Bool?
    public let minLimit : String?
    public let maxLimit : String?
    public let virtualItemDetail : VirtualRestaurantDetails?
    
    

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
        case minLimit = "minLimit"
        case maxLimit = "maxLimit"
        case virtualItemDetail = "virtualItemDetail"
    }

    public init(from decoder: Decoder) throws {
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
        minLimit = try values.decodeIfPresent(String.self, forKey: .minLimit)
        maxLimit = try values.decodeIfPresent(String.self, forKey: .maxLimit)
        virtualItemDetail = try values.decodeIfPresent(VirtualRestaurantDetails.self, forKey: .virtualItemDetail)
    }

}

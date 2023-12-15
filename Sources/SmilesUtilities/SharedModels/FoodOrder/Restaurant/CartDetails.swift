//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct CartDetails: Codable {
    public var cartId:String?
    public var totalItems: Int?
    public var totalAmount: Double?
    public var totalSavedAmount: Double?
    public var totalPoints: Int?
    public var choiceCartDetails: [ChoiceCartDetails]?
    public var restaurant: Restaurant?
    public var instructionList: [InstructionList]?
    public var address: Address?
    public var loyalityAddress: Address?
    public var deliveryTip: DeliveryTip?
    public var isChoicesAvailable: Bool?
    public var menuChoiceDetails: [MenuConfigResponseModelMenuChoiceDetail]?
    public var menuDetails: MenuConfigResponseModelMenuDetail?
    public var isCartEmpty: Bool?
    public var cartStatus: Bool?
    public var virtualEventDetails : [VirtualRestaurantDetails]?
    public var inlineItemDetails : [InlineItemDetails]?
    public var inlineItemCode : String?
    public var cartStatusDetails: CartStatusDetail?
    public var isBucketDiscountExcluded: Bool?
    
    enum CodingKeys: String, CodingKey {
        case cartId
        case totalItems
        case totalAmount
        case totalSavedAmount
        case totalPoints
        case choiceCartDetails
        case restaurant
        case instructionList
        case address
        case loyalityAddress
        case deliveryTip
        case isCartEmpty
        case isChoicesAvailable
        case menuChoiceDetails
        case menuDetails
        case cartStatus
        case virtualEventDetails
        case inlineItemDetails
        case inlineItemCode
        case cartStatusDetails
        case isBucketDiscountExcluded
    }
    
    public init() {
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cartId = try values.decodeIfPresent(String.self, forKey: .cartId)
            totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
            totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
            totalSavedAmount = try values.decodeIfPresent(Double.self, forKey: .totalSavedAmount)
            totalPoints = try values.decodeIfPresent(Int.self, forKey: .totalPoints)
            choiceCartDetails = try values.decodeIfPresent([ChoiceCartDetails].self, forKey: .choiceCartDetails)
            restaurant = try values.decodeIfPresent(Restaurant.self, forKey: .restaurant)
            instructionList = try values.decodeIfPresent([InstructionList].self, forKey: .instructionList)
            address = try values.decodeIfPresent(Address.self, forKey: .address)
            loyalityAddress = try values.decodeIfPresent(Address.self, forKey: .loyalityAddress)
            deliveryTip = try values.decodeIfPresent(DeliveryTip.self, forKey: .deliveryTip)
            isChoicesAvailable = try values.decodeIfPresent(Bool.self, forKey: .isChoicesAvailable)
            isCartEmpty = try values.decodeIfPresent(Bool.self, forKey: .isCartEmpty)
            menuChoiceDetails = try values.decodeIfPresent([MenuConfigResponseModelMenuChoiceDetail].self, forKey: .menuChoiceDetails)
            menuDetails = try values.decodeIfPresent(MenuConfigResponseModelMenuDetail.self, forKey: .menuDetails)
            cartStatus = try values.decodeIfPresent(Bool.self, forKey: .cartStatus)
            virtualEventDetails = try values.decodeIfPresent([VirtualRestaurantDetails].self, forKey: .virtualEventDetails)
            inlineItemDetails = try values.decodeIfPresent([InlineItemDetails].self, forKey: .inlineItemDetails)
            inlineItemCode = try values.decodeIfPresent(String.self, forKey: .inlineItemCode)
            cartStatusDetails = try values.decodeIfPresent(CartStatusDetail.self, forKey: .cartStatusDetails)
            isBucketDiscountExcluded = try values.decodeIfPresent(Bool.self, forKey: .isBucketDiscountExcluded)
            
        } catch {
            print(error)
        }
    }
}


public struct CartStatusDetail: Codable {
    

    public var cartStatusCode : String?
    public var cartStatusTitle: String?
    public var cartStatusDescription: String?
    public var cartStatusLeftButton: String?
    public var cartStatusRightButton: String?
    
    enum CodingKeys: String, CodingKey {
        case cartStatusCode
        case cartStatusTitle
        case cartStatusDescription
        case cartStatusLeftButton
        case cartStatusRightButton
       
    }
    
    public init() {
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cartStatusCode = try values.decodeIfPresent(String.self, forKey: .cartStatusCode)
            cartStatusTitle = try values.decodeIfPresent(String.self, forKey: .cartStatusTitle)
            cartStatusDescription = try values.decodeIfPresent(String.self, forKey: .cartStatusDescription)
            cartStatusLeftButton = try values.decodeIfPresent(String.self, forKey: .cartStatusLeftButton)
            cartStatusRightButton = try values.decodeIfPresent(String.self, forKey: .cartStatusRightButton)
            
        } catch {
            print(error)
        }
    }
}

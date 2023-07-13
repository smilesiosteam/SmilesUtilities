//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct DeliveryTip : Codable {
    public var tipHeader : String?
    public var tipDescription : String?
    public var tipDetails : [TipDetails]=[]
    
    enum CodingKeys: String, CodingKey {
        case tipHeader = "tipHeader"
        case tipDescription = "tipDescription"
        case tipDetails = "tipDetails"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tipHeader = try values.decodeIfPresent(String.self, forKey: .tipHeader)
        tipDescription = try values.decodeIfPresent(String.self, forKey: .tipDescription)
        tipDetails = try values.decodeIfPresent([TipDetails].self, forKey: .tipDetails) ?? []
    }
}

public struct TipDetails : Codable {
    public let tipInAed : String?
    public let tipValue : Int?
    public var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case tipInAed = "tipInAed"
        case tipValue = "tipValue"
        case isSelected = "isSelected"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tipInAed = try values.decodeIfPresent(String.self, forKey: .tipInAed)
        tipValue = try values.decodeIfPresent(Int.self, forKey: .tipValue)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
    }
}

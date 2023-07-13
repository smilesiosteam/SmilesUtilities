//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct InstructionList : Codable {
    public let title : String?
    public let description : String?
    public let value : String?
    public var isSelected = false
    
    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        case value = "value"
        case isSelected
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
        
    }

}

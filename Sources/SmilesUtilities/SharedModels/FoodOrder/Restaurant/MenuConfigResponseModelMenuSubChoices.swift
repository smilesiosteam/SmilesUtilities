//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct MenuConfigResponseModelMenuSubChoices : Codable {
    
    public let choiceId : String?
    public let choiceName : String?
    public let choicePrize : Double?
    public let choiceType : String?
    
    enum CodingKeys: String, CodingKey {
        case choiceId = "choiceId"
        case choiceName = "choiceName"
        case choicePrize = "choicePrize"
        case choiceType = "choiceType"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        choiceId = try values.decodeIfPresent(String.self, forKey: .choiceId)
        choiceName = try values.decodeIfPresent(String.self, forKey: .choiceName)
        choicePrize = try values.decodeIfPresent(Double.self, forKey: .choicePrize)
        choiceType = try values.decodeIfPresent(String.self, forKey: .choiceType)
    }
}

//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct MenuConfigResponseModelMenuChoice : Codable {
    
    public let choiceId : String?
    public let choiceName : String?
    public let choicePrize : Double?
    public let choiceType : String?
    public let choiceText : String?
    public let subChoices: [MenuConfigResponseModelMenuSubChoices]?
    public let isMultipleChoiceAllowed: Bool?
    public let isChoiceMandatory: Bool?
    public let multipleChoice: Int?
    public let minimumChoice: Int?
    public let defaultSelection: Int?
    public let quantityFlag: Bool?

    enum CodingKeys: String, CodingKey {
        case choiceId = "choiceId"
        case choiceName = "choiceName"
        case choicePrize = "choicePrize"
        case choiceType = "choiceType"
        case choiceText = "choiceText"
        case subChoices = "subChoices"
        case isMultipleChoiceAllowed
        case isChoiceMandatory
        case multipleChoice
        case minimumChoice
        case defaultSelection
        case quantityFlag
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        choiceId = try values.decodeIfPresent(String.self, forKey: .choiceId)
        choiceName = try values.decodeIfPresent(String.self, forKey: .choiceName)
        choicePrize = try values.decodeIfPresent(Double.self, forKey: .choicePrize)
        choiceType = try values.decodeIfPresent(String.self, forKey: .choiceType)
        choiceText = try values.decodeIfPresent(String.self, forKey: .choiceText)
        subChoices = try values.decodeIfPresent([MenuConfigResponseModelMenuSubChoices].self, forKey: .subChoices)
        isMultipleChoiceAllowed = try values.decodeIfPresent(Bool.self, forKey: .isMultipleChoiceAllowed)
        isChoiceMandatory = try values.decodeIfPresent(Bool.self, forKey: .isChoiceMandatory)
        multipleChoice = try values.decodeIfPresent(Int.self, forKey: .multipleChoice)
        minimumChoice = try values.decodeIfPresent(Int.self, forKey: .minimumChoice)
        defaultSelection = try values.decodeIfPresent(Int.self, forKey: .defaultSelection)
        quantityFlag = try values.decodeIfPresent(Bool.self, forKey: .quantityFlag)
    }
    
}

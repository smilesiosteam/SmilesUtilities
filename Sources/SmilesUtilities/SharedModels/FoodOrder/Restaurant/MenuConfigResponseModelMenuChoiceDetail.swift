//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public struct MenuConfigResponseModelMenuChoiceDetail : Codable {
    
    public let choiceHeader : String?
    public let choiceText : String?
    public let defaultSelection : Int?
    public let isChoiceMandatory : Bool?
    public let isMultipleChoiceAllowed : Bool?
    public let menuChoices : [MenuConfigResponseModelMenuChoice]?
    public let multipleChoice : Int?
    public let minimumChoice : Int?
    public let quantityFlag: Bool?
    
    enum CodingKeys: String, CodingKey {
        case choiceHeader = "choiceHeader"
        case choiceText = "choiceText"
        case defaultSelection = "defaultSelection"
        case isChoiceMandatory = "isChoiceMandatory"
        case isMultipleChoiceAllowed = "isMultipleChoiceAllowed"
        case menuChoices = "menuChoices"
        case multipleChoice = "multipleChoice"
        case minimumChoice
        case quantityFlag
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        choiceHeader = try values.decodeIfPresent(String.self, forKey: .choiceHeader)
        choiceText = try values.decodeIfPresent(String.self, forKey: .choiceText)
        defaultSelection = try values.decodeIfPresent(Int.self, forKey: .defaultSelection)
        isChoiceMandatory = try values.decodeIfPresent(Bool.self, forKey: .isChoiceMandatory)
        isMultipleChoiceAllowed = try values.decodeIfPresent(Bool.self, forKey: .isMultipleChoiceAllowed)
        menuChoices = try values.decodeIfPresent([MenuConfigResponseModelMenuChoice].self, forKey: .menuChoices)
        multipleChoice = try values.decodeIfPresent(Int.self, forKey: .multipleChoice)
        minimumChoice = try values.decodeIfPresent(Int.self, forKey: .minimumChoice)
        quantityFlag = try values.decodeIfPresent(Bool.self, forKey: .quantityFlag)
    }
    
}

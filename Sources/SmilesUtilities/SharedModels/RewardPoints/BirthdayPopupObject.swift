//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

public struct BirthdayPopupObject: Codable {
    public let title: String?
    public let description : String?
    public let imageUrl : String?
    public let leftButtonText : String?
    public let rightButtonText : String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageUrl
        case leftButtonText
        case rightButtonText
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        leftButtonText = try values.decodeIfPresent(String.self, forKey: .leftButtonText)
        rightButtonText = try values.decodeIfPresent(String.self, forKey: .rightButtonText)
    }
}

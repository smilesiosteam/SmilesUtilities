//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public class Nicknames : Codable {
    public var isSelected : Bool?
    public var nickname : String?
    public var otherNickname : String?
    public var nickNameIcon : String?

    public init(){
        
    }
    
    
    enum CodingKeys: String, CodingKey {

        case isSelected = "isSelected"
        case nickname = "nickname"
        case otherNickname = "otherNickname"
        case nickNameIcon = "nicknameIcon"
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        otherNickname = try values.decodeIfPresent(String.self, forKey: .otherNickname)
        nickNameIcon = try values.decodeIfPresent(String.self, forKey: .nickNameIcon)
    }

}

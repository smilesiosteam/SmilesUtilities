//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 30/05/2023.
//

import Foundation
import SmilesBaseMainRequestManager

public class BaseMainResponse : Codable {
    
    public var additionalInfo : [BaseMainResponseAdditionalInfo]?
    public var responseCode : String?
    public var responseMsg : String?
    public var errorCode : String?
    public var errorMsg : String?
    public var errorTitle: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case additionalInfo = "additionalInfo"
        case responseCode = "responseCode"
        case responseMsg = "responseMsg"
        case errorCode = "errorCode"
        case errorMsg = "errorMsg"
        case errorTitle = "errorTitle"
        
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        additionalInfo = try values.decodeIfPresent([BaseMainResponseAdditionalInfo].self, forKey: .additionalInfo)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        responseMsg = try values.decodeIfPresent(String.self, forKey: .responseMsg)
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode)
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg)
        errorTitle = try values.decodeIfPresent(String.self, forKey: .errorTitle)
        
    }
    
    public init() {}
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(responseCode, forKey: .responseCode)
        try container.encode(responseMsg, forKey: .responseMsg)
        try container.encode(errorCode, forKey: .errorCode)
        try container.encode(errorMsg, forKey: .errorMsg)
        
    }

    
}


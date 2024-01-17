//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 30/05/2023.
//

import Foundation

@objc open class AppUserInfo: NSObject, Codable {
    
    public var isLocationUpdated: Bool?
    public var latitude: String?
    public var location: String?
    public var locationId: String?
    public var longitude: String?
    public var mambaId: String?
    public var cityId : Int?
    public var nickName : String?
    public var cityName: String?
    
    
    enum CodingKeys: String, CodingKey {
        case isLocationUpdated
        case latitude
        case location
        case locationId
        case longitude
        case mambaId
        case cityId
        case nickName
        case cityName
    }
    
    public override init() {}
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.isLocationUpdated, forKey: .isLocationUpdated)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.location, forKey: .location)
        try container.encodeIfPresent(self.locationId, forKey: .locationId)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.mambaId, forKey: .mambaId)
        try container.encodeIfPresent(self.cityId, forKey: .cityId)
        try container.encodeIfPresent(self.nickName, forKey: .nickName)
        try container.encodeIfPresent(self.cityName, forKey: .cityName)
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isLocationUpdated = try values.decodeIfPresent(Bool.self, forKey: .isLocationUpdated)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        locationId = try values.decodeIfPresent(String.self, forKey: .locationId)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        mambaId = try values.decodeIfPresent(String.self, forKey: .mambaId)
        do {
            if let cityIdString = try values.decodeIfPresent(String.self, forKey: .cityId) {
                cityId = Int(cityIdString)
            }
        } catch DecodingError.typeMismatch {
            cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        }
        nickName = try values.decodeIfPresent(String.self, forKey: .nickName)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
    }
    
    public func asDictionary() -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded
    }
}

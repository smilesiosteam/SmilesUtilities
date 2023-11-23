//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public class Address: Codable {
    public var addressId: String?
    public var nickname: String?
    public var locationId: String?
    public var locationName: String?
    public var nicknameIcon: String?
    public var street: String?
    public var building: String?
    public var flatNo: String?
    public var landmark: String?
    public var room: String?
    public var selection: Int?
    public var userId: String?
    public var addressTitle: String?
    public var region: String?
    public var floor: String?
    public var status: String?
    public var createdDate: String?
    public var latitude: String?
    public var longitude: String?
    public var nicknames: [Nicknames]?
  

    enum CodingKeys: String, CodingKey {
        case addressId
        case nickname
        case locationId
        case locationName
        case street
        case building
        case flatNo
        case landmark
        case room
        case selection
        case userId
        case addressTitle
        case region
        case floor
        case status
        case createdDate
        case latitude
        case longitude
        case nicknames
        case nicknameIcon
    }

    public init() {}

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addressId = try values.decodeIfPresent(String.self, forKey: .addressId)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        locationId = try values.decodeIfPresent(String.self, forKey: .locationId)
        locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        building = try values.decodeIfPresent(String.self, forKey: .building)
        flatNo = try values.decodeIfPresent(String.self, forKey: .flatNo)
        landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
        room = try values.decodeIfPresent(String.self, forKey: .room)
        selection = try values.decodeIfPresent(Int.self, forKey: .selection)
        addressId = try values.decodeIfPresent(String.self, forKey: .addressId)
        locationId = try values.decodeIfPresent(String.self, forKey: .locationId)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        building = try values.decodeIfPresent(String.self, forKey: .building)
        landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        addressTitle = try values.decodeIfPresent(String.self, forKey: .addressTitle)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        floor = try values.decodeIfPresent(String.self, forKey: .floor)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        nicknameIcon = try values.decodeIfPresent(String.self, forKey: .nicknameIcon)
        nicknames = try values.decodeIfPresent([Nicknames].self, forKey: .nicknames)

    }
}

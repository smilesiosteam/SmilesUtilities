//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public class RestaurantInfoTiming: Codable {
    public var close: String?
    public var day: String?
    public var open: String?

    enum CodingKeys: String, CodingKey {
        case close
        case day
        case open
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        close = try values.decodeIfPresent(String.self, forKey: .close)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        open = try values.decodeIfPresent(String.self, forKey: .open)
    }
}

//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 12/07/2023.
//

import Foundation

public class RestaurantMenu: Codable {
    public var itemCategory: String?
    public var itemCategoryId: String?
    public var menu: [Menu]?
    public var isSelected: Bool?

    enum CodingKeys: String, CodingKey {
        case itemCategory
        case itemCategoryId
        case menu
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemCategory = try values.decodeIfPresent(String.self, forKey: .itemCategory)
        itemCategoryId = try values.decodeIfPresent(String.self, forKey: .itemCategoryId)
        menu = try values.decodeIfPresent([Menu].self, forKey: .menu)
    }

    public init() {}
}

//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 11/07/2023.
//

import Foundation
import SmilesBaseMainRequestManager

public class OffersCategoryRequestModel: SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    
    var pageNo: Int?
    var categoryId: String?
    var searchByLocation: Bool?
    var sortingType: String?
    var subCategoryId: String?
    var subCategoryTypeIdsList: [String]?
    var isGuestUser: Bool?
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case pageNo
        case categoryId
        case searchByLocation
        case sortingType
        case subCategoryId
        case subCategoryTypeIdsList
        case isGuestUser
    }
    
    public init(pageNo: Int? = nil, categoryId: String?, searchByLocation: Bool? = nil, sortingType: String? = nil, subCategoryId: String? = nil, subCategoryTypeIdsList: [String]? = nil, isGuestUser: Bool? = nil) {
        super.init()
        self.pageNo = pageNo
        self.categoryId = categoryId
        self.searchByLocation = searchByLocation
        self.sortingType = sortingType
        self.subCategoryId = subCategoryId
        self.subCategoryTypeIdsList = subCategoryTypeIdsList
        self.isGuestUser = isGuestUser
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.pageNo, forKey: .pageNo)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        try container.encodeIfPresent(self.searchByLocation, forKey: .searchByLocation)
        try container.encodeIfPresent(self.sortingType, forKey: .sortingType)
        try container.encodeIfPresent(self.subCategoryId, forKey: .subCategoryId)
        try container.encodeIfPresent(self.subCategoryTypeIdsList, forKey: .subCategoryTypeIdsList)
        try container.encodeIfPresent(self.isGuestUser, forKey: .isGuestUser)
    }
}

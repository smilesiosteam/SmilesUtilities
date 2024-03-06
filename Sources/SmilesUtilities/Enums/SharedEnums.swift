//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 12/10/2023.
//

import Foundation

public enum ServiceErrorTypes: Int {
    case noContent = 0, errorContent = 1,  noRaffles = 2, noNotification = 3
}

public enum ConsentCategoryType : String, Codable {
    case elGrocer = "order_grocery_consent", yallaCompare = "yallacompare_consent", servicemarketConsent = "servicemarket_consent", topBrand = "top_brand_consent", collectionConsent = "collection_consent", easyInsurance = "insurance_website_consent"
}

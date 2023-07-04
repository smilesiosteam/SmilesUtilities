//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 03/07/2023.
//

import Foundation

public class PaymentMethod: Codable {
    public var paymentMethodId: String?
    public var paymentMethodsDescription: String?
    public var iconUrl: String?
    public var title: String?
    public var isSavedCreditCard: Bool?
    public var titleAr: String?
    public var cardNumber: String?
    public var subType: String?
    public var cardImg: String?
    public var isDisable: Bool?
    public var paymentTypeText: String?
    public var paymentType: String?
    
    enum CodingKeys: String, CodingKey {
        case paymentMethodId
        case paymentMethodsDescription = "description"
        case title
        case iconUrl
        case titleAr
        case cardNumber
        case subType
        case cardImg
        case isDisable
        case paymentTypeText
        case paymentType
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paymentMethodId = try values.decodeIfPresent(String.self, forKey: .paymentMethodId)
        paymentMethodsDescription = try values.decodeIfPresent(String.self, forKey: .paymentMethodsDescription)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        cardNumber = try values.decodeIfPresent(String.self, forKey: .cardNumber)
        subType = try values.decodeIfPresent(String.self, forKey: .subType)
        cardImg = try values.decodeIfPresent(String.self, forKey: .cardImg)
        isDisable = try values.decodeIfPresent(Bool.self, forKey: .isDisable)
        paymentTypeText = try values.decodeIfPresent(String.self, forKey: .paymentTypeText)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
    }

    public func getTitle() -> String {
        if AppCommonMethods.languageIsArabic() {
            return titleAr.asStringOrEmpty()
        } else {
            return title.asStringOrEmpty()
        }
    }
    
    public func asDictionary(dictionary: [String: Any]) -> [String: Any] {
        let encoder = DictionaryEncoder()
        guard let encoded = try? encoder.encode(self) as [String: Any] else {
            return [:]
        }
        return encoded.mergeDictionaries(dictionary: dictionary)
    }
}

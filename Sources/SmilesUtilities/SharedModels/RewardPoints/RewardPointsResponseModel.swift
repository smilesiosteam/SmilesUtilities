//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 04/07/2023.
//

import Foundation

public struct RewardPointsResponseModel: Codable {
    public let extTransactionId: String?
    public let totalPoints : Int?
    public let nextExpiryDate : String?
    public let pointsToExpire : Int?
    public let tierImageUrl : String?
    public let accountType : String?
    public let hasLinkedAccounts : Bool?
    public let message : String?
    public let lifestyleSubscription : Bool?
    public let foodSubscription: Bool?
    public let loyaltyId: String?
    public let emailAddress: String?
    public let smileyPointsUrl: String?
    public let name: String?
    public let dateOfBirth: String?
    public let nationalityId: Int?
    public let communicationLanguageList: [CommunicationLanguageListSwift]?
    public let phoneNumber: String?
    public let rewardsTier: Int?
    public let nextTierRemainingPoints: Int?
    public let nextTierPointsthreshold: Int?
    public let lifetimeSavings: Double?
    public let gender: String?
    public let referralCode: String?
    public let referralCodeMsg: String?
    public var responseCode : String?
    public var responseMsg : String?
    public let tierLevel : String?
    public let nationalitiesList: [NationalitiesListSwift]?
    public let email: String?
    public let expiryDate: String?
    public let rewardsPointsAvailable: Int?
    public let communicationLanguageId: Int?
    public let nextRewardsTier: Int?
    public let lastAccrualPoints: Int?
    public let lastRedeemedPoints: Int?
    public let lastRedemptionDate: String?
    public let lastAccrualDate: String?
    public let coBandCard:String?
    public let inviteFriendText: String?
    public let isOfferSuccessfullyPurchased: Bool?
    public let showSmileyAnimation: Bool?
    public let showBirthdayPopup: Bool?
    public let birthdayPopup: BirthdayPopupObject?
    public let mcfcSubscriptionStatus: Bool?
    public let mcfcWelcomeVideoUrl: String?

    public var profileImagePlaceholder: String{
        if gender == "F"{
            return "female"
        }
        else{
            return "male"
        }
    }

    
    public var rewardPointsTierLevel: RewardTierLevel{
        
        switch tierLevel {
        case "1":
            return .gold
        case "2":
            return .silver
        case "3":
            return .bronze
        default:
            return .none
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case extTransactionId
        case totalPoints
        case nextExpiryDate
        case pointsToExpire
        case tierImageUrl
        case accountType
        case hasLinkedAccounts
        case message
        case lifestyleSubscription
        case foodSubscription
        case loyaltyId
        case emailAddress
        case smileyPointsUrl
        case name
        case dateOfBirth
        case nationalityId
        case communicationLanguageList
        case phoneNumber
        case rewardsTier
        case nextTierRemainingPoints
        case nextTierPointsthreshold
        case lifetimeSavings
        case gender
        case referralCode
        case referralCodeMsg
        case responseCode
        case responseMsg
        case tierLevel
        case nationalitiesList
        case email
        case expiryDate
        case rewardsPointsAvailable
        case communicationLanguageId
        case nextRewardsTier
        case lastAccrualPoints
        case lastRedeemedPoints
        case lastRedemptionDate
        case lastAccrualDate
        case coBandCard
        case inviteFriendText
        case isOfferSuccessfullyPurchased
        case showSmileyAnimation
        case showBirthdayPopup
        case birthdayPopup
        case mcfcSubscriptionStatus
        case mcfcWelcomeVideoUrl = "welcomeVideoUrl"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        extTransactionId = try values.decodeIfPresent(String.self, forKey: .extTransactionId)
        totalPoints = try values.decodeIfPresent(Int.self, forKey: .totalPoints)
        nextExpiryDate = try values.decodeIfPresent(String.self, forKey: .nextExpiryDate)
        pointsToExpire = try values.decodeIfPresent(Int.self, forKey: .pointsToExpire)
        tierImageUrl = try values.decodeIfPresent(String.self, forKey: .tierImageUrl)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        hasLinkedAccounts = try values.decodeIfPresent(Bool.self, forKey: .hasLinkedAccounts)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        lifestyleSubscription = try values.decodeIfPresent(Bool.self, forKey: .lifestyleSubscription)
        foodSubscription = try values.decodeIfPresent(Bool.self, forKey: .foodSubscription)
        loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress)
        smileyPointsUrl = try values.decodeIfPresent(String.self, forKey: .smileyPointsUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        nationalityId = try values.decodeIfPresent(Int.self, forKey: .nationalityId)
        communicationLanguageList = try values.decodeIfPresent([CommunicationLanguageListSwift].self, forKey: .communicationLanguageList)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        rewardsTier = try values.decodeIfPresent(Int.self, forKey: .rewardsTier)
        nextTierRemainingPoints = try values.decodeIfPresent(Int.self, forKey: .nextTierRemainingPoints)
        nextTierPointsthreshold = try values.decodeIfPresent(Int.self, forKey: .nextTierPointsthreshold)
        lifetimeSavings = try values.decodeIfPresent(Double.self, forKey: .lifetimeSavings)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
        referralCodeMsg = try values.decodeIfPresent(String.self, forKey: .referralCodeMsg)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        responseMsg = try values.decodeIfPresent(String.self, forKey: .responseMsg)
        tierLevel = try values.decodeIfPresent(String.self, forKey: .tierLevel)
        nationalitiesList = try values.decodeIfPresent([NationalitiesListSwift].self, forKey: .nationalitiesList)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
        rewardsPointsAvailable = try values.decodeIfPresent(Int.self, forKey: .rewardsPointsAvailable)
        communicationLanguageId = try values.decodeIfPresent(Int.self, forKey: .communicationLanguageId)
        nextRewardsTier = try values.decodeIfPresent(Int.self, forKey: .nextRewardsTier)
        lastAccrualPoints = try values.decodeIfPresent(Int.self, forKey: .lastAccrualPoints)
        lastRedeemedPoints = try values.decodeIfPresent(Int.self, forKey: .lastRedeemedPoints)
        lastRedemptionDate = try values.decodeIfPresent(String.self, forKey: .lastRedemptionDate)
        lastAccrualDate = try values.decodeIfPresent(String.self, forKey: .lastAccrualDate)
        coBandCard = try values.decodeIfPresent(String.self, forKey: .coBandCard)
        inviteFriendText = try values.decodeIfPresent(String.self, forKey: .inviteFriendText)
        isOfferSuccessfullyPurchased = try values.decodeIfPresent(Bool.self, forKey: .isOfferSuccessfullyPurchased)
        showSmileyAnimation = try values.decodeIfPresent(Bool.self, forKey: .showSmileyAnimation)
        showBirthdayPopup = try values.decodeIfPresent(Bool.self, forKey: .showBirthdayPopup)
        birthdayPopup = try values.decodeIfPresent(BirthdayPopupObject.self, forKey: .birthdayPopup)
        mcfcSubscriptionStatus = try values.decodeIfPresent(Bool.self, forKey: .mcfcSubscriptionStatus)
        mcfcWelcomeVideoUrl = try values.decodeIfPresent(String.self, forKey: .mcfcWelcomeVideoUrl)
    }
}

public enum RewardTierLevel: Int {
    case gold = 0, silver = 4, bronze = 1, none = -1
}

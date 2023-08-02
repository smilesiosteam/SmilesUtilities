//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 17/07/2023.
//

import Foundation

@objcMembers
public class GetEligibilityMatrixResponse: NSObject, NSCoding, NSCopying {
    
    public var responseCode: String?
    public var responseMsg: String?
    public var additionalInfo: [Any]?
    public var extTransactionId: String?
    public var eligibleFeatures: [Any]?
    public var nonEligibleFeatures: [Any]?
    public var emailVerified: Bool = false
    public var accountType: String?
    public var isEtisalatUser: Bool = false
    public var accountTypeNumber: String?
    public var loyaltyID: String?
    public var emailAddress: String?
    public var hasLinkedAccounts: Bool = false
    public var notEligibleObject: NotEligibleObject?
    
    public required override init() {
        super.init()
        
    }
    
    public required init(withDictionary: NSDictionary) {
        super.init()
        self.eligibleFeatures = withDictionary["eligibleFeatures"] as? [Any]
        self.nonEligibleFeatures = withDictionary["nonEligibleFeatures"] as? [Any]
        self.emailVerified = (withDictionary["emailVerified"] as? Bool) ?? false
        self.accountType = withDictionary["accountType"] as? String
        self.isEtisalatUser = (withDictionary["etisalatUser"] as? Bool) ?? false
        self.accountTypeNumber = withDictionary["accountTypeNumber"] as? String
        self.loyaltyID = withDictionary["loyaltyID"] as? String
        self.emailAddress = withDictionary["emailAddress"] as? String
        self.hasLinkedAccounts = (withDictionary["hasLinkedAccounts"] as? Bool) ?? false
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.responseCode = aDecoder.decodeObject(forKey: "responseCode") as? String
        self.responseMsg = aDecoder.decodeObject(forKey: "responseMsg") as? String
        self.additionalInfo = aDecoder.decodeObject(forKey: "additionalInfo") as? [Any]
        self.extTransactionId = aDecoder.decodeObject(forKey: "extTransactionId") as? String
        self.eligibleFeatures = aDecoder.decodeObject(forKey: "eligibleFeatures") as? [Any]
        self.nonEligibleFeatures = aDecoder.decodeObject(forKey: "nonEligibleFeatures") as? [Any]
        self.emailVerified = aDecoder.decodeBool(forKey: "emailVerified")
        self.accountType = aDecoder.decodeObject(forKey: "accountType") as? String
        self.isEtisalatUser = aDecoder.decodeBool(forKey: "etisalatUser")
        self.accountTypeNumber = aDecoder.decodeObject(forKey: "accountTypeNumber") as? String
        self.loyaltyID = aDecoder.decodeObject(forKey: "loyaltyID") as? String
        self.emailAddress = aDecoder.decodeObject(forKey: "emailAddress") as? String
        self.hasLinkedAccounts = aDecoder.decodeBool(forKey: "hasLinkedAccounts")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.responseCode, forKey: "responseCode")
        aCoder.encode(self.responseMsg, forKey: "responseMsg")
        aCoder.encode(self.additionalInfo, forKey: "additionalInfo")
        aCoder.encode(self.extTransactionId, forKey: "extTransactionId")
        aCoder.encode(self.eligibleFeatures, forKey: "eligibleFeatures")
        aCoder.encode(self.nonEligibleFeatures, forKey: "nonEligibleFeatures")
        aCoder.encode(self.emailVerified, forKey: "emailVerified")
        aCoder.encode(self.accountType, forKey: "accountType")
        aCoder.encode(self.isEtisalatUser, forKey: "etisalatUser")
        aCoder.encode(self.accountTypeNumber, forKey: "accountTypeNumber")
        aCoder.encode(self.loyaltyID, forKey: "loyaltyID")
        aCoder.encode(self.emailAddress, forKey: "emailAddress")
        aCoder.encode(self.hasLinkedAccounts, forKey: "hasLinkedAccounts")
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = type(of: self).init()
        copy.responseCode = self.responseCode
        copy.responseMsg = self.responseMsg
        copy.additionalInfo = self.additionalInfo
        copy.extTransactionId = self.extTransactionId
        copy.eligibleFeatures = self.eligibleFeatures
        copy.nonEligibleFeatures = self.nonEligibleFeatures
        copy.emailVerified = self.emailVerified
        copy.accountType = self.accountType
        copy.isEtisalatUser = self.isEtisalatUser
        copy.accountTypeNumber = self.accountTypeNumber
        copy.loyaltyID = self.loyaltyID
        copy.emailAddress = self.emailAddress
        copy.hasLinkedAccounts = self.hasLinkedAccounts
        return copy
    }
    
    public class func modelObject(withDictionary dict: [String: Any]) -> GetEligibilityMatrixResponse? {
        let instance = GetEligibilityMatrixResponse()
        instance.responseCode = dict["responseCode"] as? String
        instance.responseMsg = dict["responseMsg"] as? String
        instance.additionalInfo = dict["additionalInfo"] as? [Any]
        instance.extTransactionId = dict["extTransactionId"] as? String
        instance.eligibleFeatures = dict["eligibleFeatures"] as? [Any]
        instance.nonEligibleFeatures = dict["nonEligibleFeatures"] as? [Any]
        instance.emailVerified = dict["emailVerified"] as? Bool ?? false
        instance.accountType = dict["accountType"] as? String
        instance.isEtisalatUser = dict["etisalatUser"] as? Bool ?? false
        instance.accountTypeNumber = dict["accountTypeNumber"] as? String
        instance.loyaltyID = dict["loyaltyID"] as? String
        instance.emailAddress = dict["emailAddress"] as? String
        instance.hasLinkedAccounts = dict["hasLinkedAccounts"] as? Bool ?? false
        return instance
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["responseCode"] = self.responseCode
        dictionary["responseMsg"] = self.responseMsg
        dictionary["additionalInfo"] = self.additionalInfo
        dictionary["extTransactionId"] = self.extTransactionId
        dictionary["eligibleFeatures"] = self.eligibleFeatures
        dictionary["nonEligibleFeatures"] = self.nonEligibleFeatures
        dictionary["emailVerified"] = self.emailVerified
        dictionary["accountType"] = self.accountType
        dictionary["etisalatUser"] = self.isEtisalatUser
        dictionary["accountTypeNumber"] = self.accountTypeNumber
        dictionary["loyaltyID"] = self.loyaltyID
        dictionary["emailAddress"] = self.emailAddress
        dictionary["hasLinkedAccounts"] = self.hasLinkedAccounts
        return dictionary
    }
    
    public static let sharedInstance = GetEligibilityMatrixResponse()
}

@objcMembers
public class NotEligibleObject: NSObject, Codable {
    
    public var devicesSmartpay: Bool = false
    public var devicesPromoCode: Bool = false
    public var devicesNotifyMe: Bool = false
    public var referFriend: Bool = false
    public var customizedEtisalatOffers: Bool = false
    public var eTBillRecharge: Bool = false
    public var gamification: Bool = false
    public var shareVoucher: Bool = false
    public var dealsForYou: Bool = false
    public var lifestyle: Bool = false
    public var thirdPartyOffers: Bool = false
    public var devicesStandalone: Bool = false
    public var genericPromoCode: Bool = false
    public var cinema: Bool = false
    public var cbdAcquisition: Bool = false
    public var foodOrder: Bool = false
    public var elGrocer: Bool = false
    
    // Back-End
    public var dCBPayment: Bool = false
    public var redemptionServicesVouchers: Bool = false
    public var rechargeAccount: Bool = false
    public var payInternationalCC: Bool = false
    public var secureTransaction: Bool = false
    public var accrualPartnersPurchases: Bool = false
    public var payLocalCC: Bool = false
    public var canParent: Bool = false
    public var pointsRecovery: Bool = false
    public var coBrandedCard: Bool = false
    public var referralBonusFirstTrx: Bool = false
    public var appZeroData: Bool = false
    public var payBill: Bool = false
    public var accrualETServices: Bool = false
    public var bonusGiftFirstActivity: Bool = false
    public var accountCancellation: Bool = false
    public var oTPLoginAdInfo: Bool = false
    public var oTPLoginSignup: Bool = false
    public var enroll: Bool = false
    public var usernamePassLogin: Bool = false
    
    public required override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case devicesSmartpay = "Devices_Smartpay"
        case redemptionServicesVouchers = "Redemption_services_vouchers"
        case accrualETServices = "Accrual_ET_services"
        case rechargeAccount = "Recharge_account"
        case customizedEtisalatOffers = "Customized_Etisalat_offers"
        case bonusGiftFirstActivity = "Bonus_gift_first_activity"
        case devicesPromoCode = "devices_promo_code"
        case devicesStandalone = "Devices_Standalone"
        case payInternationalCC = "Pay_international_CC"
        case dCBPayment = "DCB_payment"
        case secureTransaction = "3D_secure_transaction"
        case oTPLoginAdInfo = "OTP_login_ad_info"
        case accrualPartnersPurchases = "Accrual_partners_purchases"
        case payLocalCC = "Pay_local_CC"
        case canParent = "can_parent"
        case devicesNotifyMe = "devices_notify_me"
        case pointsRecovery = "Points_recovery"
        case genericPromoCode = "PROMO_CODE"
        case payBill = "Pay_bill"
        case referFriend = "refer_friend"
        case eTBillRecharge = "ET_bill_Recharge"
        case gamification = "Gamification"
        case lifestyle = "Lifestyle"
        case appZeroData = "app_zero_data"
        case oTPLoginSignup = "OTP_login_signup"
        case shareVoucher = "Share_voucher"
        case coBrandedCard = "Co-branded_Card"
        case referralBonusFirstTrx = "referral_bonus_first_trx"
        case thirdPartyOffers = "Third_party_offers"
        case dealsForYou = "Deals_for_you"
        case enroll = "Enroll"
        case cinema = "Cinema"
        case usernamePassLogin = "username_pass_login"
        case cbdAcquisition = "cbdAcquisition"
        case foodOrder = "FoodOrder"
        case elGrocer = "elGrocer"
        case accountCancellation = "ACCOUNT_CANCELLATION"
    }
    
    public required init(from aDecoder: Decoder) throws {
        
        let values = try aDecoder.container(keyedBy: CodingKeys.self)
        self.devicesSmartpay = try values.decode(Bool.self, forKey: .devicesSmartpay)
        self.devicesPromoCode = try values.decode(Bool.self, forKey: .devicesPromoCode)
        self.devicesNotifyMe = try values.decode(Bool.self, forKey: .devicesNotifyMe)
        self.referFriend = try values.decode(Bool.self, forKey: .referFriend)
        self.customizedEtisalatOffers = try values.decode(Bool.self, forKey: .customizedEtisalatOffers)
        self.eTBillRecharge = try values.decode(Bool.self, forKey: .eTBillRecharge)
        self.gamification = try values.decode(Bool.self, forKey: .gamification)
        self.shareVoucher = try values.decode(Bool.self, forKey: .shareVoucher)
        self.dealsForYou = try values.decode(Bool.self, forKey: .dealsForYou)
        self.lifestyle = try values.decode(Bool.self, forKey: .lifestyle)
        self.thirdPartyOffers = try values.decode(Bool.self, forKey: .thirdPartyOffers)
        self.devicesStandalone = try values.decode(Bool.self, forKey: .devicesStandalone)
        self.genericPromoCode = try values.decode(Bool.self, forKey: .genericPromoCode)
        self.cinema = try values.decode(Bool.self, forKey: .cinema)
        self.cbdAcquisition = try values.decode(Bool.self, forKey: .cbdAcquisition)
        self.foodOrder = try values.decode(Bool.self, forKey: .foodOrder)
        self.elGrocer = try values.decode(Bool.self, forKey: .elGrocer)
        self.redemptionServicesVouchers = try values.decode(Bool.self, forKey: .redemptionServicesVouchers)
        self.accrualETServices = try values.decode(Bool.self, forKey: .accrualETServices)
        self.rechargeAccount = try values.decode(Bool.self, forKey: .rechargeAccount)
        self.bonusGiftFirstActivity = try values.decode(Bool.self, forKey: .bonusGiftFirstActivity)
        self.payInternationalCC = try values.decode(Bool.self, forKey: .payInternationalCC)
        self.dCBPayment = try values.decode(Bool.self, forKey: .dCBPayment)
        self.secureTransaction = try values.decode(Bool.self, forKey: .secureTransaction)
        self.oTPLoginAdInfo = try values.decode(Bool.self, forKey: .oTPLoginAdInfo)
        self.accrualPartnersPurchases = try values.decode(Bool.self, forKey: .accrualPartnersPurchases)
        self.payLocalCC = try values.decode(Bool.self, forKey: .payLocalCC)
        self.canParent = try values.decode(Bool.self, forKey: .canParent)
        self.pointsRecovery = try values.decode(Bool.self, forKey: .pointsRecovery)
        self.payBill = try values.decode(Bool.self, forKey: .payBill)
        self.appZeroData = try values.decode(Bool.self, forKey: .appZeroData)
        self.oTPLoginSignup = try values.decode(Bool.self, forKey: .oTPLoginSignup)
        self.coBrandedCard = try values.decode(Bool.self, forKey: .coBrandedCard)
        self.referralBonusFirstTrx = try values.decode(Bool.self, forKey: .referralBonusFirstTrx)
        self.enroll = try values.decode(Bool.self, forKey: .enroll)
        self.usernamePassLogin = try values.decode(Bool.self, forKey: .usernamePassLogin)
        self.accountCancellation = try values.decode(Bool.self, forKey: .accountCancellation)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode each Bool property using the corresponding CodingKey
        try container.encode(self.devicesSmartpay, forKey: .devicesSmartpay)
        try container.encode(self.devicesPromoCode, forKey: .devicesPromoCode)
        try container.encode(self.devicesNotifyMe, forKey: .devicesNotifyMe)
        try container.encode(self.referFriend, forKey: .referFriend)
        try container.encode(self.customizedEtisalatOffers, forKey: .customizedEtisalatOffers)
        try container.encode(self.eTBillRecharge, forKey: .eTBillRecharge)
        try container.encode(self.gamification, forKey: .gamification)
        try container.encode(self.shareVoucher, forKey: .shareVoucher)
        try container.encode(self.dealsForYou, forKey: .dealsForYou)
        try container.encode(self.lifestyle, forKey: .lifestyle)
        try container.encode(self.thirdPartyOffers, forKey: .thirdPartyOffers)
        try container.encode(self.devicesStandalone, forKey: .devicesStandalone)
        try container.encode(self.genericPromoCode, forKey: .genericPromoCode)
        try container.encode(self.cinema, forKey: .cinema)
        try container.encode(self.cbdAcquisition, forKey: .cbdAcquisition)
        try container.encode(self.foodOrder, forKey: .foodOrder)
        try container.encode(self.elGrocer, forKey: .elGrocer)
        try container.encode(self.redemptionServicesVouchers, forKey: .redemptionServicesVouchers)
        try container.encode(self.accrualETServices, forKey: .accrualETServices)
        try container.encode(self.rechargeAccount, forKey: .rechargeAccount)
        try container.encode(self.bonusGiftFirstActivity, forKey: .bonusGiftFirstActivity)
        try container.encode(self.payInternationalCC, forKey: .payInternationalCC)
        try container.encode(self.dCBPayment, forKey: .dCBPayment)
        try container.encode(self.secureTransaction, forKey: .secureTransaction)
        try container.encode(self.oTPLoginAdInfo, forKey: .oTPLoginAdInfo)
        try container.encode(self.accrualPartnersPurchases, forKey: .accrualPartnersPurchases)
        try container.encode(self.payLocalCC, forKey: .payLocalCC)
        try container.encode(self.canParent, forKey: .canParent)
        try container.encode(self.pointsRecovery, forKey: .pointsRecovery)
        try container.encode(self.payBill, forKey: .payBill)
        try container.encode(self.appZeroData, forKey: .appZeroData)
        try container.encode(self.oTPLoginSignup, forKey: .oTPLoginSignup)
        try container.encode(self.coBrandedCard, forKey: .coBrandedCard)
        try container.encode(self.referralBonusFirstTrx, forKey: .referralBonusFirstTrx)
        try container.encode(self.enroll, forKey: .enroll)
        try container.encode(self.usernamePassLogin, forKey: .usernamePassLogin)
        try container.encode(self.accountCancellation, forKey: .accountCancellation)
    }
    
}

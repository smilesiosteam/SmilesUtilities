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
        self.isEtisalatUser = (withDictionary["isEtisalatUser"] as? Bool) ?? false
        self.accountTypeNumber = withDictionary["accountTypeNumber"] as? String
        self.loyaltyID = withDictionary["loyaltyID"] as? String
        self.emailAddress = withDictionary["emailAddress"] as? String
        self.hasLinkedAccounts = (withDictionary["hasLinkedAccounts"] as? Bool) ?? false
        
        if let notEligibleObjectDict = withDictionary["notEligibleObject"] as? [String: Any] {
            self.notEligibleObject = NotEligibleObject.modelObject(withDictionary: notEligibleObjectDict)
        }
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
        self.isEtisalatUser = aDecoder.decodeBool(forKey: "isEtisalatUser")
        self.accountTypeNumber = aDecoder.decodeObject(forKey: "accountTypeNumber") as? String
        self.loyaltyID = aDecoder.decodeObject(forKey: "loyaltyID") as? String
        self.emailAddress = aDecoder.decodeObject(forKey: "emailAddress") as? String
        self.hasLinkedAccounts = aDecoder.decodeBool(forKey: "hasLinkedAccounts")
        self.notEligibleObject = aDecoder.decodeObject(forKey: "notEligibleObject") as? NotEligibleObject
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
        aCoder.encode(self.isEtisalatUser, forKey: "isEtisalatUser")
        aCoder.encode(self.accountTypeNumber, forKey: "accountTypeNumber")
        aCoder.encode(self.loyaltyID, forKey: "loyaltyID")
        aCoder.encode(self.emailAddress, forKey: "emailAddress")
        aCoder.encode(self.hasLinkedAccounts, forKey: "hasLinkedAccounts")
        aCoder.encode(self.notEligibleObject, forKey: "notEligibleObject")
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
        copy.notEligibleObject = self.notEligibleObject
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
        instance.isEtisalatUser = dict["isEtisalatUser"] as? Bool ?? false
        instance.accountTypeNumber = dict["accountTypeNumber"] as? String
        instance.loyaltyID = dict["loyaltyID"] as? String
        instance.emailAddress = dict["emailAddress"] as? String
        instance.hasLinkedAccounts = dict["hasLinkedAccounts"] as? Bool ?? false
        instance.notEligibleObject = dict["notEligibleObject"] as? NotEligibleObject
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
        dictionary["isEtisalatUser"] = self.isEtisalatUser
        dictionary["accountTypeNumber"] = self.accountTypeNumber
        dictionary["loyaltyID"] = self.loyaltyID
        dictionary["emailAddress"] = self.emailAddress
        dictionary["hasLinkedAccounts"] = self.hasLinkedAccounts
        dictionary["notEligibleObject"] = self.notEligibleObject
        return dictionary
    }
    
    public static let sharedInstance = GetEligibilityMatrixResponse()
}

@objcMembers
public class NotEligibleObject: NSObject, NSCoding, NSCopying {
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
    
    public required override init() {
        super.init()
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.devicesSmartpay = aDecoder.decodeBool(forKey: "devicesSmartpay")
        self.devicesPromoCode = aDecoder.decodeBool(forKey: "devicesPromoCode")
        self.devicesNotifyMe = aDecoder.decodeBool(forKey: "devicesNotifyMe")
        self.referFriend = aDecoder.decodeBool(forKey: "referFriend")
        self.customizedEtisalatOffers = aDecoder.decodeBool(forKey: "customizedEtisalatOffers")
        self.eTBillRecharge = aDecoder.decodeBool(forKey: "eTBillRecharge")
        self.gamification = aDecoder.decodeBool(forKey: "gamification")
        self.shareVoucher = aDecoder.decodeBool(forKey: "shareVoucher")
        self.dealsForYou = aDecoder.decodeBool(forKey: "dealsForYou")
        self.lifestyle = aDecoder.decodeBool(forKey: "lifestyle")
        self.thirdPartyOffers = aDecoder.decodeBool(forKey: "thirdPartyOffers")
        self.devicesStandalone = aDecoder.decodeBool(forKey: "devicesStandalone")
        self.genericPromoCode = aDecoder.decodeBool(forKey: "genericPromoCode")
        self.cinema = aDecoder.decodeBool(forKey: "cinema")
        self.cbdAcquisition = aDecoder.decodeBool(forKey: "cbdAcquisition")
        self.foodOrder = aDecoder.decodeBool(forKey: "foodOrder")
        self.elGrocer = aDecoder.decodeBool(forKey: "elGrocer")
        
        // Ignore the keys that are not needed (No Need to Decode)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.devicesSmartpay, forKey: "devicesSmartpay")
        aCoder.encode(self.devicesPromoCode, forKey: "devicesPromoCode")
        aCoder.encode(self.devicesNotifyMe, forKey: "devicesNotifyMe")
        aCoder.encode(self.referFriend, forKey: "referFriend")
        aCoder.encode(self.customizedEtisalatOffers, forKey: "customizedEtisalatOffers")
        aCoder.encode(self.eTBillRecharge, forKey: "eTBillRecharge")
        aCoder.encode(self.gamification, forKey: "gamification")
        aCoder.encode(self.shareVoucher, forKey: "shareVoucher")
        aCoder.encode(self.dealsForYou, forKey: "dealsForYou")
        aCoder.encode(self.lifestyle, forKey: "lifestyle")
        aCoder.encode(self.thirdPartyOffers, forKey: "thirdPartyOffers")
        aCoder.encode(self.devicesStandalone, forKey: "devicesStandalone")
        aCoder.encode(self.genericPromoCode, forKey: "genericPromoCode")
        aCoder.encode(self.cinema, forKey: "cinema")
        aCoder.encode(self.cbdAcquisition, forKey: "cbdAcquisition")
        aCoder.encode(self.foodOrder, forKey: "foodOrder")
        aCoder.encode(self.elGrocer, forKey: "elGrocer")
        
        // Ignore the keys that are not needed (No Need to Encode)
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = type(of: self).init()
        copy.devicesSmartpay = self.devicesSmartpay
        copy.devicesPromoCode = self.devicesPromoCode
        copy.devicesNotifyMe = self.devicesNotifyMe
        copy.referFriend = self.referFriend
        copy.customizedEtisalatOffers = self.customizedEtisalatOffers
        copy.eTBillRecharge = self.eTBillRecharge
        copy.gamification = self.gamification
        copy.shareVoucher = self.shareVoucher
        copy.dealsForYou = self.dealsForYou
        copy.lifestyle = self.lifestyle
        copy.thirdPartyOffers = self.thirdPartyOffers
        copy.devicesStandalone = self.devicesStandalone
        copy.genericPromoCode = self.genericPromoCode
        copy.cinema = self.cinema
        copy.cbdAcquisition = self.cbdAcquisition
        copy.foodOrder = self.foodOrder
        copy.elGrocer = self.elGrocer
        
        // Ignore the keys that are not needed (No Need to Copy)
        
        return copy
    }
    
    public class func modelObject(withDictionary dict: [String: Any]) -> NotEligibleObject? {
        let instance = NotEligibleObject()
        instance.devicesSmartpay = dict["devicesSmartpay"] as? Bool ?? false
        instance.devicesPromoCode = dict["devicesPromoCode"] as? Bool ?? false
        instance.devicesNotifyMe = dict["devicesNotifyMe"] as? Bool ?? false
        instance.referFriend = dict["referFriend"] as? Bool ?? false
        instance.customizedEtisalatOffers = dict["customizedEtisalatOffers"] as? Bool ?? false
        instance.eTBillRecharge = dict["eTBillRecharge"] as? Bool ?? false
        instance.gamification = dict["gamification"] as? Bool ?? false
        instance.shareVoucher = dict["shareVoucher"] as? Bool ?? false
        instance.dealsForYou = dict["dealsForYou"] as? Bool ?? false
        instance.lifestyle = dict["lifestyle"] as? Bool ?? false
        instance.thirdPartyOffers = dict["thirdPartyOffers"] as? Bool ?? false
        instance.devicesStandalone = dict["devicesStandalone"] as? Bool ?? false
        instance.genericPromoCode = dict["genericPromoCode"] as? Bool ?? false
        instance.cinema = dict["cinema"] as? Bool ?? false
        instance.cbdAcquisition = dict["cbdAcquisition"] as? Bool ?? false
        instance.foodOrder = dict["foodOrder"] as? Bool ?? false
        instance.elGrocer = dict["elGrocer"] as? Bool ?? false
        
        // Ignore the keys that are not needed
        
        return instance
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["devicesSmartpay"] = self.devicesSmartpay
        dictionary["devicesPromoCode"] = self.devicesPromoCode
        dictionary["devicesNotifyMe"] = self.devicesNotifyMe
        dictionary["referFriend"] = self.referFriend
        dictionary["customizedEtisalatOffers"] = self.customizedEtisalatOffers
        dictionary["eTBillRecharge"] = self.eTBillRecharge
        dictionary["gamification"] = self.gamification
        dictionary["shareVoucher"] = self.shareVoucher
        dictionary["dealsForYou"] = self.dealsForYou
        dictionary["lifestyle"] = self.lifestyle
        dictionary["thirdPartyOffers"] = self.thirdPartyOffers
        dictionary["devicesStandalone"] = self.devicesStandalone
        dictionary["genericPromoCode"] = self.genericPromoCode
        dictionary["cinema"] = self.cinema
        dictionary["cbdAcquisition"] = self.cbdAcquisition
        dictionary["foodOrder"] = self.foodOrder
        dictionary["elGrocer"] = self.elGrocer
        
        // Ignore the keys that are not needed
        
        return dictionary
    }
}

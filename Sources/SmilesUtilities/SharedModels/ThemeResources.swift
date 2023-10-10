//
//  File.swift
//  
//
//  Created by Habib Rehman on 24/08/2023.
//

import Foundation
//import SmilesUtilities


public class ThemeResources: Codable {
    
    public let manageSubscriptionDescText: String?
    public let subscribedTitle: String?
    public let subscribeButtonDesc: String?
    public let authorizeCardTitle: String?
    public let lifestyleNonEligibleImageUrl: String?
    public let authorizeCardDesc: String?
    public let otherSubscription: String?
    public let cancelSubscriptionButtonText: String?
    public let termsAndConditionTitle: [String]?
    public let manageSubscriptionSubTitle: String?
    public let authorizeCardIconUrl: String?
    public let cancelSubscriptionDescText: String?
    public let cancelSubscriptionTitle: String?
    public let promoCodeTitle: String?
    public let lifestyleLogoUrl: String?
    public let subscriptionPaymentMethodText: String?
    public let foodSegementRedirectionName: String?
    public let lifestyleImageUrl: String?
    public let subscribeButtonText: String?
    public let lifestyleNonEligbileText: String?
    public let lifestyleTitle: String?
    public let promoCodeButtonText: String?
    public let manageSubscriptionTitle: String?
    public let subscriptionDescGreenText: String?
    public let lifestyleSegementRedirectionName: String?
    public let lifestyleSubTitle: String?
    public let orderSummaryText: String?
    public let lifestyleShortTitle: String?
    public let manageSubscriptionButtonText: String?
    public let changePaymentMethodText: String?
    public let cancelSubscriptionSubTitle: String?
    public let subscriptionAutoRenewsText: String?
    public let subscriptionChannelText: String?
    public let subscriptionTitle: String?
    public let exclusiveSubscriptionTitle: String?
    public let cancellationPopupDesc: String?
    public let cancellationSuccessPopupSubTitle: String?
    public let subscriptionExpandDescText: [String]?
    public let cancellationLandingSubTitle: String?
    public let cancellationLandingTitle: String?
    public let cancellationLandingReason: [String]?
    public let subscriptionActiveText: String?
    public let cancellationLandingButton: String?
    public let cancellationPopupLeftButton: String?
    public let cancellationSuccessPopupTitle: String?
    public let cancellationPopupTitle: String?
    public let autoRenewSubscriptionSubTitle: String?
    public let cancellationLandingDesc: String?
    public let giftCardDetailsText: String?
    public let cancellationPopupSubTitle: String?
    public let cancellationNoteText: String?
    public let subscriptionParkedText: String?
    public let autoRenewSubscriptionTitle: String?
    public let cancellationPopupRightButton: String?
    public let autoRenewSubscriptionDesc: String?
    public let orderSummaryFirstDays: String?
    public let orderSummaryAfterDays: String?
    public let subscriptionExpriyText: String?
    public let subscribtionFreeElifeUltra: String?
    public let subscriptionOnHoldText: String?
    public let subscriptionFreedomPlan: String?
    public let subscriptionAedMonth: String?
    public let subscribeCardEndingText: String?
    public let giftCardDescription: String?
    public let giftCardTitle: String?
    public let giftCardAppliedText: String?
    public let cancellationLandingBenefitTitle: String?
    public let lifetimeSavingDesc: String?
    public let lifetimeSavingTitle: String?
    
    public let explorerTopPlaceholderTitle: String?
    public let explorerTopPlaceholderIcon: String?
    public let explorerSubscriptionTitle: String?
    public let explorerSubscriptionSubTitle: String?
    public let explorerPurchaseSuccessImage: String?
    public let explorerPurchaseSuccessTitle: String?
    public let passPurchaseSuccessMsg: String?
    public let ticketPurchaseSuccessMsg: String?
    
    enum CodingKeys: String, CodingKey {
        
        case manageSubscriptionDescText
        case subscribedTitle
        case subscribeButtonDesc
        case authorizeCardTitle
        case lifestyleNonEligibleImageUrl
        case authorizeCardDesc
        case otherSubscription
        case cancelSubscriptionButtonText
        case termsAndConditionTitle
        case manageSubscriptionSubTitle
        case authorizeCardIconUrl
        case cancelSubscriptionDescText
        case cancelSubscriptionTitle
        case promoCodeTitle
        case lifestyleLogoUrl
        case subscriptionPaymentMethodText
        case foodSegementRedirectionName
        case lifestyleImageUrl
        case subscribeButtonText
        case lifestyleNonEligbileText
        case lifestyleTitle
        case promoCodeButtonText
        case manageSubscriptionTitle
        case subscriptionDescGreenText
        case lifestyleSegementRedirectionName
        case lifestyleSubTitle
        case orderSummaryText
        case lifestyleShortTitle
        case manageSubscriptionButtonText
        case changePaymentMethodText
        case cancelSubscriptionSubTitle
        case subscriptionAutoRenewsText
        case subscriptionChannelText
        case subscriptionTitle
        case exclusiveSubscriptionTitle
        case cancellationPopupDesc
        case cancellationSuccessPopupSubTitle
        case subscriptionExpandDescText
        case cancellationLandingSubTitle
        case cancellationLandingTitle
        case cancellationLandingReason
        case subscriptionActiveText
        case cancellationLandingButton
        case cancellationPopupLeftButton
        case cancellationSuccessPopupTitle
        case cancellationPopupTitle
        case autoRenewSubscriptionSubTitle
        case cancellationLandingDesc
        case giftCardDetailsText
        case cancellationPopupSubTitle
        case cancellationNoteText
        case subscriptionParkedText
        case autoRenewSubscriptionTitle
        case cancellationPopupRightButton
        case autoRenewSubscriptionDesc
        case orderSummaryFirstDays
        case orderSummaryAfterDays
        case subscriptionExpriyText
        case subscribtionFreeElifeUltra
        case subscriptionOnHoldText
        case subscriptionFreedomPlan
        case subscriptionAedMonth
        case subscribeCardEndingText
        case giftCardDescription
        case giftCardTitle
        case giftCardAppliedText
        case cancellationLandingBenefitTitle
        case lifetimeSavingDesc
        case lifetimeSavingTitle
        
        case explorerTopPlaceholderTitle
        case explorerTopPlaceholderIcon
        case explorerSubscriptionTitle
        case explorerSubscriptionSubTitle
        case explorerPurchaseSuccessImage
        case explorerPurchaseSuccessTitle
        case passPurchaseSuccessMsg
        case ticketPurchaseSuccessMsg
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        manageSubscriptionDescText = try values.decodeIfPresent(String.self, forKey: .manageSubscriptionDescText)
        subscribedTitle = try values.decodeIfPresent(String.self, forKey: .subscribedTitle)
        subscribeButtonDesc = try values.decodeIfPresent(String.self, forKey: .subscribeButtonDesc)
        authorizeCardTitle = try values.decodeIfPresent(String.self, forKey: .authorizeCardTitle)
        
        lifestyleNonEligibleImageUrl = try values.decodeIfPresent(String.self, forKey: .lifestyleNonEligibleImageUrl)
        authorizeCardDesc = try values.decodeIfPresent(String.self, forKey: .authorizeCardDesc)
        
        otherSubscription = try values.decodeIfPresent(String.self, forKey: .otherSubscription)
        
        cancelSubscriptionButtonText = try values.decodeIfPresent(String.self, forKey: .cancelSubscriptionButtonText)
        termsAndConditionTitle = try values.decodeIfPresent([String].self, forKey: .termsAndConditionTitle)
        manageSubscriptionSubTitle = try values.decodeIfPresent(String.self, forKey: .manageSubscriptionSubTitle)
        authorizeCardIconUrl = try values.decodeIfPresent(String.self, forKey: .authorizeCardIconUrl)
        cancelSubscriptionDescText = try values.decodeIfPresent(String.self, forKey: .cancelSubscriptionDescText)
        
        cancelSubscriptionTitle = try values.decodeIfPresent(String.self, forKey: .cancelSubscriptionTitle)
        promoCodeTitle = try values.decodeIfPresent(String.self, forKey: .promoCodeTitle)
        lifestyleLogoUrl = try values.decodeIfPresent(String.self, forKey: .lifestyleLogoUrl)
        subscriptionPaymentMethodText = try values.decodeIfPresent(String.self, forKey: .subscriptionPaymentMethodText)
        foodSegementRedirectionName = try values.decodeIfPresent(String.self, forKey: .foodSegementRedirectionName)
        lifestyleImageUrl = try values.decodeIfPresent(String.self, forKey: .lifestyleImageUrl)
        subscribeButtonText = try values.decodeIfPresent(String.self, forKey: .subscribeButtonText)
        lifestyleNonEligbileText = try values.decodeIfPresent(String.self, forKey: .lifestyleNonEligbileText)
        lifestyleTitle = try values.decodeIfPresent(String.self, forKey: .lifestyleTitle)
        promoCodeButtonText = try values.decodeIfPresent(String.self, forKey: .promoCodeButtonText)
        manageSubscriptionTitle = try values.decodeIfPresent(String.self, forKey: .manageSubscriptionTitle)
        subscriptionDescGreenText = try values.decodeIfPresent(String.self, forKey: .subscriptionDescGreenText)
        lifestyleSegementRedirectionName = try values.decodeIfPresent(String.self, forKey: .lifestyleSegementRedirectionName)
        lifestyleSubTitle = try values.decodeIfPresent(String.self, forKey: .lifestyleSubTitle)
        orderSummaryText = try values.decodeIfPresent(String.self, forKey: .orderSummaryText)
        lifestyleShortTitle = try values.decodeIfPresent(String.self, forKey: .lifestyleShortTitle)
        manageSubscriptionButtonText = try values.decodeIfPresent(String.self, forKey: .manageSubscriptionButtonText)
        changePaymentMethodText = try values.decodeIfPresent(String.self, forKey: .changePaymentMethodText)
        cancelSubscriptionSubTitle = try values.decodeIfPresent(String.self, forKey: .cancelSubscriptionSubTitle)
        subscriptionAutoRenewsText = try values.decodeIfPresent(String.self, forKey: .subscriptionAutoRenewsText)
        subscriptionChannelText = try values.decodeIfPresent(String.self, forKey: .subscriptionChannelText)
        subscriptionTitle = try values.decodeIfPresent(String.self, forKey: .subscriptionTitle)
        exclusiveSubscriptionTitle = try values.decodeIfPresent(String.self, forKey: .exclusiveSubscriptionTitle)
        cancellationPopupDesc = try values.decodeIfPresent(String.self, forKey: .cancellationPopupDesc)
        cancellationSuccessPopupSubTitle = try values.decodeIfPresent(String.self, forKey: .cancellationSuccessPopupSubTitle)
        subscriptionExpandDescText = try values.decodeIfPresent([String].self, forKey: .subscriptionExpandDescText)
        cancellationLandingSubTitle = try values.decodeIfPresent(String.self, forKey: .cancellationLandingSubTitle)
        cancellationLandingTitle = try values.decodeIfPresent(String.self, forKey: .cancellationLandingTitle)
        cancellationLandingReason = try values.decodeIfPresent([String].self, forKey: .cancellationLandingReason)
        subscriptionActiveText = try values.decodeIfPresent(String.self, forKey: .subscriptionActiveText)
        cancellationLandingButton = try values.decodeIfPresent(String.self, forKey: .cancellationLandingButton)
        cancellationPopupLeftButton = try values.decodeIfPresent(String.self, forKey: .cancellationPopupLeftButton)
        cancellationSuccessPopupTitle = try values.decodeIfPresent(String.self, forKey: .cancellationSuccessPopupTitle)
        cancellationPopupTitle = try values.decodeIfPresent(String.self, forKey: .cancellationPopupTitle)
        autoRenewSubscriptionSubTitle = try values.decodeIfPresent(String.self, forKey: .autoRenewSubscriptionSubTitle)
        cancellationLandingDesc = try values.decodeIfPresent(String.self, forKey: .cancellationLandingDesc)
        giftCardDetailsText = try values.decodeIfPresent(String.self, forKey: .giftCardDetailsText)
        cancellationPopupSubTitle = try values.decodeIfPresent(String.self, forKey: .cancellationPopupSubTitle)
        cancellationNoteText = try values.decodeIfPresent(String.self, forKey: .cancellationNoteText)
        subscriptionParkedText = try values.decodeIfPresent(String.self, forKey: .subscriptionParkedText)
        autoRenewSubscriptionTitle = try values.decodeIfPresent(String.self, forKey: .autoRenewSubscriptionTitle)
        cancellationPopupRightButton = try values.decodeIfPresent(String.self, forKey: .cancellationPopupRightButton)
        autoRenewSubscriptionDesc = try values.decodeIfPresent(String.self, forKey: .autoRenewSubscriptionDesc)
        orderSummaryFirstDays = try values.decodeIfPresent(String.self, forKey: .orderSummaryFirstDays)
        orderSummaryAfterDays = try values.decodeIfPresent(String.self, forKey: .orderSummaryAfterDays)
        subscriptionExpriyText = try values.decodeIfPresent(String.self, forKey: .subscriptionExpriyText)
        subscribtionFreeElifeUltra = try values.decodeIfPresent(String.self, forKey: .subscribtionFreeElifeUltra)
        subscriptionOnHoldText = try values.decodeIfPresent(String.self, forKey: .subscriptionOnHoldText)
        subscriptionFreedomPlan = try values.decodeIfPresent(String.self, forKey: .subscriptionFreedomPlan)
        subscriptionAedMonth = try values.decodeIfPresent(String.self, forKey: .subscriptionAedMonth)
        subscribeCardEndingText = try values.decodeIfPresent(String.self, forKey: .subscribeCardEndingText)
        giftCardDescription = try values.decodeIfPresent(String.self, forKey: .giftCardDescription)
        giftCardTitle = try values.decodeIfPresent(String.self, forKey: .giftCardTitle)
        giftCardAppliedText = try values.decodeIfPresent(String.self, forKey: .giftCardAppliedText)
        cancellationLandingBenefitTitle = try values.decodeIfPresent(String.self, forKey: .cancellationLandingBenefitTitle)
        lifetimeSavingDesc = try values.decodeIfPresent(String.self, forKey: .lifetimeSavingDesc)
        lifetimeSavingTitle = try values.decodeIfPresent(String.self, forKey: .lifetimeSavingTitle)
        
        explorerTopPlaceholderTitle = try values.decodeIfPresent(String.self, forKey: .explorerTopPlaceholderTitle)
        explorerTopPlaceholderIcon = try values.decodeIfPresent(String.self, forKey: .explorerTopPlaceholderIcon)
        explorerSubscriptionTitle = try values.decodeIfPresent(String.self, forKey: .explorerSubscriptionTitle)
        explorerSubscriptionSubTitle = try values.decodeIfPresent(String.self, forKey: .explorerSubscriptionSubTitle)
        explorerPurchaseSuccessImage = try values.decodeIfPresent(String.self, forKey: .explorerPurchaseSuccessImage)
        explorerPurchaseSuccessTitle = try values.decodeIfPresent(String.self, forKey: .explorerPurchaseSuccessTitle)
        passPurchaseSuccessMsg = try values.decodeIfPresent(String.self, forKey: .passPurchaseSuccessMsg)
        ticketPurchaseSuccessMsg = try values.decodeIfPresent(String.self, forKey: .ticketPurchaseSuccessMsg)
        
    }
}

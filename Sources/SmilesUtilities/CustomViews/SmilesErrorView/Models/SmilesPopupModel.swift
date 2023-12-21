//
//  File.swift
//
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import Foundation
import UIKit

public struct SmilesPopupModel {
    
    let image: UIImage?
    let title: String?
    let description: String?
    var primaryButtonTitle: String
    var secondaryButtonTitle: String?
    let popUpType: MessagePresentationType
    let showForRetry: Bool
    
    public init(errorImage: UIImage? = nil, title: String? = nil, description: String? = nil, primaryButtonTitle: String = "btn_Ok".localizedString, secondaryButtonTitle: String? = nil, errorViewType: MessagePresentationType = .popUp, showForRetry: Bool = false) {
        self.image = errorImage
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.popUpType = errorViewType
        self.showForRetry = showForRetry
    }
    
}

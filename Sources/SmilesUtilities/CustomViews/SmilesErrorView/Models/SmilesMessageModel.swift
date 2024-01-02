//
//  File.swift
//
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import Foundation
import UIKit

public struct SmilesMessageModel {
    
    let image: UIImage?
    let title: String?
    let description: String?
    var primaryButtonTitle: String
    var secondaryButtonTitle: String?
    public let presentationType: MessagePresentationType
    let showForRetry: Bool
    
    public init(image: UIImage? = nil, title: String? = nil, description: String? = nil, primaryButtonTitle: String = "btn_Ok".localizedString, secondaryButtonTitle: String? = nil, presentationType: MessagePresentationType = .popUp, showForRetry: Bool = false) {
        self.image = image
        self.title = title
        self.description = description
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.presentationType = presentationType
        self.showForRetry = showForRetry
    }
    
}

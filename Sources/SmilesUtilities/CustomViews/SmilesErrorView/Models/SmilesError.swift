//
//  File.swift
//
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import Foundation
import UIKit

public struct SmilesError {
    
    let errorImage: UIImage?
    let title: String?
    let description: String?
    let buttonTitle: String
    let errorViewType: ErrorViewType
    
    public init(errorImage: UIImage? = nil, title: String? = nil, description: String? = nil, buttonTitle: String = "OK", errorViewType: ErrorViewType = .popUp) {
        self.errorImage = errorImage
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.errorViewType = errorViewType
    }
    
}

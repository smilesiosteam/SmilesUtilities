//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 12/10/2023.
//

import Foundation

enum NoContentKeys {
    case noContent
    case serviceFail
    case nORaffleResults
    case noNotificationTitle
    case nibName
    case errorImageString
    
    var text: String {
        
        switch self {
        case .noContent:
            return "NoContent"
        case .serviceFail:
            return "ServiceFail"
        case .nORaffleResults:
            return "NORaffleResults"
        case .noNotificationTitle:
            return "NoNotificationTitle"
        case .nibName:
            return "NoContentView"
        case .errorImageString:
            return "Empty"
        }
    }
}

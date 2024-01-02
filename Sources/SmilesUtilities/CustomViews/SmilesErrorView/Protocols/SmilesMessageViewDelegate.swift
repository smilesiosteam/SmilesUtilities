//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 14/12/2023.
//

import Foundation

public protocol SmilesMessageViewDelegate: AnyObject {
    func primaryButtonPressed(isForRetry: Bool)
    func secondaryButtonPressed()
}

public extension SmilesMessageViewDelegate {
    func primaryButtonPressed(isForRetry: Bool) {}
    func secondaryButtonPressed() {}
}

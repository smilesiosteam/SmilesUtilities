//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 14/12/2023.
//

import Foundation

public protocol SmilesMessageViewDelegate: AnyObject {
    func primaryButtonPressed()
    func secondaryButtonPressed()
}

extension SmilesMessageViewDelegate {
    func primaryButtonPressed() {}
    func secondaryButtonPressed() {}
}

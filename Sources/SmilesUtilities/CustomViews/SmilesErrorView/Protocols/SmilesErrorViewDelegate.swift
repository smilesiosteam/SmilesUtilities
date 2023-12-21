//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 14/12/2023.
//

import Foundation

public protocol SmilesErrorViewDelegate: AnyObject {
    func primaryButtonPressed()
    func secondaryButtonPressed()
}

extension SmilesErrorViewDelegate {
    func primaryButtonPressed() {}
    func secondaryButtonPressed() {}
}

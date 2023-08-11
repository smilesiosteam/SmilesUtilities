//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 11/08/2023.
//

import Foundation

public protocol BaseViewControllerDelegate: AnyObject {
    func shouldTransformBackNavbarButton()
    func shouldTransformViewHeaderAsLabel()
}

public extension BaseViewControllerDelegate {
    func shouldTransformBackNavbarButton() {}
    
    func shouldTransformViewHeaderAsLabel() {}
}

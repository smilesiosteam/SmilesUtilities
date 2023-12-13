//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import Foundation
import UIKit

public class SmilesErrorHandler {
    
    public static let shared = SmilesErrorHandler()
    
    private init() {}
    
    public func showError(on vc: UIViewController, error: SmilesError, buttonPressed: (() -> Void)? = nil) {
        
        let errorVC = SmilesErrorView(error: error, buttonPressed: buttonPressed)
        errorVC.modalPresentationStyle = error.errorViewType == .fullScreen ? .overFullScreen : .overCurrentContext
        errorVC.modalTransitionStyle = error.errorViewType == .fullScreen ? .coverVertical : .crossDissolve
        vc.present(errorVC, animated: true)
        
    }
    
}
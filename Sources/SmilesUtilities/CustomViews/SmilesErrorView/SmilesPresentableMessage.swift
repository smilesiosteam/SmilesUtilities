//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import Foundation
import UIKit

public protocol SmilesPresentableMessage {
    func showMessage(model: SmilesPopupModel, delegate: SmilesMessageViewDelegate?)
}

public extension SmilesPresentableMessage where Self: UIViewController {
    
    func showMessage(model: SmilesPopupModel, delegate: SmilesMessageViewDelegate? = nil) {
        
        let messageVC = SmilesPopupView(model: model, delegate: delegate)
        messageVC.modalPresentationStyle = model.popUpType == .fullScreen ? .overFullScreen : .overCurrentContext
        messageVC.modalTransitionStyle = model.popUpType == .fullScreen ? .coverVertical : .crossDissolve
        self.present(messageVC, animated: true)
        
    }
    
}

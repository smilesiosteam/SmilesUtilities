//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import Foundation
import UIKit

public protocol SmilesPresentableMessage {
    func showMessage(model: SmilesMessageModel, delegate: SmilesMessageViewDelegate?)
}

public extension SmilesPresentableMessage where Self: UIViewController {
    
    func showMessage(model: SmilesMessageModel, delegate: SmilesMessageViewDelegate? = nil) {
        
        let messageVC = SmilesMessageView(model: model, delegate: delegate)
        messageVC.modalPresentationStyle = model.presentationType == .fullScreen ? .overFullScreen : .overCurrentContext
        messageVC.modalTransitionStyle = model.presentationType == .fullScreen ? .coverVertical : .crossDissolve
        self.present(messageVC, animated: true)
        
    }
    
}

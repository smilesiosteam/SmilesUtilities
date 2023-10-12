//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 12/10/2023.
//

import UIKit
import SmilesLanguageManager

public protocol NoContentViewDelegate {
    func retryButtonAction()
}

public class NoContentView: UIView, NibLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var retryBtnParentView: UIView!
    @IBOutlet private weak var lbl_error: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var img_error: UIImageView!
    @IBOutlet private weak var btn_retry: UIButton!
    
    //MARK: - Properties
    private let nibName = NoContentKeys.nibName.text
    private let errorMSG = SmilesLanguageManager.shared.getLocalizedString(for: "NoContent")
    private var delegate : NoContentViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
        img_error.image = UIImage(named: NoContentKeys.errorImageString.text)
    }
    
    private func showErrorTextByType(errorType: ServiceErrorTypes){
        switch errorType {
        case .noContent:
            lbl_error.text = SmilesLanguageManager.shared.getLocalizedString(for: NoContentKeys.noContent.text)
            
        case .errorContent:
            lbl_error.text = SmilesLanguageManager.shared.getLocalizedString(for: NoContentKeys.serviceFail.text)
            
        case .noRaffles:
            lbl_error.text = SmilesLanguageManager.shared.getLocalizedString(for: NoContentKeys.nORaffleResults.text)
            
        case .noNotification:
            lbl_error.text = SmilesLanguageManager.shared.getLocalizedString(for: NoContentKeys.noNotificationTitle.text)
        }
    }
    
    public func showError(errorText: String?, errorType: ServiceErrorTypes){
        if let text = errorText, !text.isEmpty{
            self.lbl_error.text = text
        }
        else{
            showErrorTextByType(errorType: errorType)
        }
    }
    
    //MARK: - Button Actions
    @IBAction private func didSelectRetryButtonAction(_ sender: Any) {
        if delegate != nil{
            self.delegate?.retryButtonAction()
        }
    }
}

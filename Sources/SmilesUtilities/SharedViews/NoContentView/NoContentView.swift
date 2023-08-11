

//
//  NoContentView.swift
//  House
//
//  Created by Ahmed samir ali on 10/7/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesLanguageManager

public protocol NoContentViewDelegate {
    func retryButtonAction()
}

public class NoContentView: UIView, NibLoadable {
    
    @IBOutlet weak var retryBtnParentView: UIView!
    @IBOutlet weak private var lbl_error : UILabel!
    @IBOutlet weak private var containerView : UIView!
    @IBOutlet weak private var img_error : UIImageView!
    @IBOutlet weak private var btn_retry : UIButton!
    let nibName = "NoContentView"
    private let errorMSG = "NoContent".localizedString
    private var delegate : NoContentViewDelegate?
    
    
    var errorTitle: String? {
        get { return errorMSG  }
        set { lbl_error.text = newValue}
    }
    
    var errorImageString: String? {
        get { return "Empty" }
        set { img_error.image = UIImage(named: newValue.asStringOrEmpty())}
    }
    
    var showRetryButton: Bool {
        get { return false }
        set { retryBtnParentView.isHidden = newValue }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
        setupFromNib()
    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
    
    
//    private func commonInit(){
//        Bundle.main.loadNibNamed("NoContentView", owner: self, options: nil)
//        addSubview(containerView)
//        containerView.bounds = self.bounds
//        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    
    private func showErrorTextByType(errorType : serviceErrorTypes){
        switch errorType {
        case .noContent:
            lbl_error.text = "NoContent".localizedString
            break
            
        case .errorContent:
            lbl_error.text = "ServiceFail".localizedString
            
            break
            
        case .noRaffles:
            lbl_error.text = "NORaffleResults".localizedString
            break
            
        case .noNotification:
            lbl_error.text = "NoNotificationTitle".localizedString
            break
        }
    }
    
    public func showError(errorText : String?, errorType : serviceErrorTypes){
        if let text = errorText, !text.isEmpty{
            self.lbl_error.text = text
        }
        else{
            showErrorTextByType(errorType: errorType)
        }
    }
    
    
    
    //MARK:- button action
    
    @IBAction private func didSelectRetryButtonAction(_ sender: Any) {
        if delegate != nil{
            self.delegate?.retryButtonAction()
        }
    }
    
}

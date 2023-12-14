//
//  SmilesErrorView 2.swift
//  
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import UIKit

public enum ErrorViewType {
    case fullScreen, popUp
}

class SmilesErrorView: UIViewController {

    // MARK: - OUTLETS -
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var primaryButton: UICustomButton!
    @IBOutlet weak var secondaryButton: UICustomButton!
    @IBOutlet weak var popUpButtonsStack: UIStackView!
    @IBOutlet weak var buttonsStack: UIStackView!
    
    // MARK: - PROPERTIES -
    private var errorViewType: ErrorViewType = .popUp
    private var error: SmilesError
    private weak var delegate: SmilesErrorViewDelegate?
    
    // MARK: - ACTIONS -
    @IBAction func primaryButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        delegate?.primaryButtonPressed()
    }
    
    @IBAction func secondaryButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        delegate?.secondaryButtonPressed()
    }
    
    // MARK: - INITIALIZERS -
    init(error: SmilesError, delegate: SmilesErrorViewDelegate?) {
        self.error = error
        self.delegate = delegate
        super.init(nibName: "SmilesErrorView", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        errorImageView.isHidden = error.errorImage == nil
        errorImageView.image = error.errorImage
        setupLabel(label: titleLabel, text: error.title)
        setupLabel(label: descriptionLabel, text: error.description)
        
        if error.showForRetry {
            error.primaryButtonTitle = "btn_Retry".localizedString
            error.secondaryButtonTitle = "btn_Ok".localizedString
        }
        
        primaryButton.setTitle(error.primaryButtonTitle, for: .normal)
        secondaryButton.setTitle(error.secondaryButtonTitle, for: .normal)
        secondaryButton.isHidden = error.secondaryButtonTitle == nil
        
        self.errorViewType = error.errorViewType
        view.backgroundColor = errorViewType == .fullScreen ? .white : .black.withAlphaComponent(0.6)
        buttonsStack.isHidden = errorViewType == .popUp
        popUpButtonsStack.isHidden = errorViewType == .fullScreen
        
    }
    
    private func setupLabel(label: UILabel, text: String?) {
        
        if let text {
            label.isHidden = text.isEmpty
            label.text = text
        } else {
            label.isHidden = true
        }
        
    }

}

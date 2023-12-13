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
    @IBOutlet weak var popUpButton: UICustomButton!
    @IBOutlet weak var retryButton: UICustomButton!
    
    // MARK: - PROPERTIES -
    private var errorViewType: ErrorViewType = .popUp
    private var buttonPressed: (() -> Void)?
    private var error: SmilesError
    
    // MARK: - ACTIONS -
    @IBAction func buttonTapped(_ sender: Any) {
        dismiss(animated: true)
        buttonPressed?()
    }
    
    // MARK: - INITIALIZERS -
    init(error: SmilesError, buttonPressed: (() -> Void)? = nil) {
        self.error = error
        self.buttonPressed = buttonPressed
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
        
        popUpButton.setTitle(error.buttonTitle, for: .normal)
        retryButton.setTitle(error.buttonTitle, for: .normal)
        
        self.errorViewType = error.errorViewType
        view.backgroundColor = errorViewType == .fullScreen ? .white : .black.withAlphaComponent(0.2)
        retryButton.isHidden = errorViewType == .fullScreen
        popUpButton.isHidden = errorViewType == .popUp
        
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

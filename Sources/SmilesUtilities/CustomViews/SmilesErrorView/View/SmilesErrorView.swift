//
//  SmilesErrorView 2.swift
//  
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import UIKit
import SmilesFontsManager

public enum ErrorViewType {
    case fullScreen, popUp
}

class SmilesErrorView: UIViewController {

    // MARK: - OUTLETS -
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var popUpButtonsStack: UIStackView!
    @IBOutlet weak var buttonsStack: UIStackView!
    
    // MARK: - PROPERTIES -
    private var errorViewType: ErrorViewType = .popUp
    private var error: SmilesError
    private weak var delegate: SmilesErrorViewDelegate?
    
    // MARK: - VIEWS -
    private let primaryButton: UICustomButton = {
        let button = UICustomButton()
        button.backgroundColor = UIColor(hexString: "75428E")
        button.setTitleColor(.white, for: .normal)
        button.fontTextStyle = .smilesHeadline4
        button.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(SmilesErrorView.self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let secondaryButton: UICustomButton = {
        let button = UICustomButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor(hexString: "75428E"), for: .normal)
        button.borderWidth = 1.5
        button.borderColor = UIColor(hexString: "75428E").withAlphaComponent(0.4)
        button.fontTextStyle = .smilesHeadline4
        button.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(SmilesErrorView.self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - ACTIONS -
    @objc func primaryButtonTapped() {
        dismiss(animated: true)
        delegate?.primaryButtonPressed()
    }
    
    @objc func secondaryButtonTapped() {
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
        
        self.errorViewType = error.errorViewType
        view.backgroundColor = errorViewType == .fullScreen ? .white : .black.withAlphaComponent(0.6)
        buttonsStack.isHidden = errorViewType == .popUp
        popUpButtonsStack.isHidden = errorViewType == .fullScreen
        
        if errorViewType == .popUp {
            if error.secondaryButtonTitle != nil {
                popUpButtonsStack.addArrangedSubview(secondaryButton)
            }
            popUpButtonsStack.addArrangedSubview(primaryButton)
        } else {
            if error.secondaryButtonTitle != nil {
                buttonsStack.addArrangedSubview(secondaryButton)
            }
            buttonsStack.addArrangedSubview(primaryButton)
        }
        
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

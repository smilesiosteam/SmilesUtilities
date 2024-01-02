//
//  SmilesMessageView 2.swift
//  
//
//  Created by Abdul Rehman Amjad on 13/12/2023.
//

import UIKit
import SmilesFontsManager

public enum MessagePresentationType {
    case fullScreen, popUp
}

public class SmilesMessageView: UIViewController {

    // MARK: - OUTLETS -
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var popUpButtonsStack: UIStackView!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var popUpButtonStackWidth: NSLayoutConstraint!
    
    // MARK: - PROPERTIES -
    private var presentationType: MessagePresentationType = .popUp
    private var model: SmilesMessageModel
    private weak var delegate: SmilesMessageViewDelegate?
    
    // MARK: - VIEWS -
    private let primaryButton: UICustomButton = {
        let button = UICustomButton()
        button.backgroundColor = UIColor(hexString: "75428E")
        button.setTitleColor(.white, for: .normal)
        button.fontTextStyle = .smilesHeadline4
        button.clipsToBounds = true
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
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - ACTIONS -
    @objc func primaryButtonTapped() {
        dismiss(animated: true)
        delegate?.primaryButtonPressed(isForRetry: model.showForRetry)
    }
    
    @objc func secondaryButtonTapped() {
        dismiss(animated: true)
        delegate?.secondaryButtonPressed()
    }
    
    // MARK: - INITIALIZERS -
    public init(model: SmilesMessageModel, delegate: SmilesMessageViewDelegate?) {
        self.model = model
        self.delegate = delegate
        super.init(nibName: "SmilesMessageView", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS -
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        primaryButton.cornerRadius = presentationType == .popUp ? popUpButtonsStack.frame.height / 2 : buttonsStack.frame.height / 2
        secondaryButton.cornerRadius = presentationType == .popUp ? popUpButtonsStack.frame.height / 2 : buttonsStack.frame.height / 2
    }
    
    private func setupViews() {
        
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        
        errorImageView.isHidden = model.image == nil
        errorImageView.image = model.image
        setupLabel(label: titleLabel, text: model.title)
        setupLabel(label: descriptionLabel, text: model.description)
        
        if model.showForRetry {
            model.primaryButtonTitle = "btn_Retry".localizedString
            model.secondaryButtonTitle = "btn_Ok".localizedString
        }
        
        primaryButton.setTitle(model.primaryButtonTitle, for: .normal)
        secondaryButton.setTitle(model.secondaryButtonTitle, for: .normal)
        
        self.presentationType = model.presentationType
        view.backgroundColor = presentationType == .fullScreen ? .white : .black.withAlphaComponent(0.6)
        buttonsStack.isHidden = presentationType == .popUp
        popUpButtonsStack.isHidden = presentationType == .fullScreen
        
        if presentationType == .popUp {
            let popUpBtnWidth = UIScreen.main.bounds.width * 0.25
            if model.secondaryButtonTitle != nil {
                popUpButtonsStack.addArrangedSubview(secondaryButton)
                popUpButtonStackWidth.constant = (popUpBtnWidth * 2) + 8
            } else {
                popUpButtonStackWidth.constant = popUpBtnWidth
            }
            popUpButtonsStack.addArrangedSubview(primaryButton)
        } else {
            if model.secondaryButtonTitle != nil {
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

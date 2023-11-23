//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 23/11/2023.
//

import UIKit
import SmilesFontsManager

public final class ToastView: UIView {
    
     // MARK: - Properties
    private let iconImageView = UIImageView()
    private let messageLabel = UILabel()
    private let stackView = UIStackView()
    private let toastModel: ToastModel
    
    // MARK: - Init
   public init(toastModel: ToastModel) {
        self.toastModel = toastModel
        super.init(frame: CGRect.zero)
        configureView()
        configureIconImageView()
        configureMessageLabel()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func configureView() {
        backgroundColor = toastModel.backgroundColor
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureIconImageView() {
        let isHidden = toastModel.imageIcon == nil
        iconImageView.isHidden = isHidden
        
        iconImageView.image = toastModel.imageIcon
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        messageLabel.text = toastModel.title
        messageLabel.textColor = toastModel.titileColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.fontTextStyle = toastModel.titleStyle
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupView() {
        // Configure the stack view
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2

        // Add arranged subviews to the stack view
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(messageLabel)

        // Add the stack view to the ToastView
        addSubview(stackView)

        // Set constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

public struct ToastModel {
    
    public init() {}
    public var title: String?
    public var imageIcon: UIImage?
    public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    public var titileColor: UIColor = .white
    public var titleStyle: UIFont.TextStyle = .smilesHeadline5
}

public protocol Toastable {
    func showToast(model: ToastModel)
}

extension Toastable where Self: UIViewController {
    func showToast(model: ToastModel) {
        let toastView = ToastView(toastModel: model)

        view.addSubview(toastView)

        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            toastView.heightAnchor.constraint(equalToConstant: 50)
        ])

        UIView.animate(withDuration: 0.3, delay: 10.0, options: .curveEaseOut, animations: {
            toastView.alpha = 0
        }) { _ in
            toastView.removeFromSuperview()
        }
    }
}

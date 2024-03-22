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
        addTapGesture()
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
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    
    private func configureMessageLabel() {
        messageLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        if let attributedString = toastModel.attributedString {
            messageLabel.attributedText = attributedString
        } else {
            messageLabel.text = toastModel.title
            messageLabel.fontTextStyle = toastModel.titleStyle
        }
        
        messageLabel.textColor = toastModel.titileColor
        messageLabel.textAlignment = toastModel.titleAlignment
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            messageLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: 0)
        ])
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelAction))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelAction() {
        toastModel.viewDidTapped?()
    }
    
    
}

public class ToastModel {
    
    public init() {}
    public var title: String?
    public var imageIcon: UIImage?
    public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    public var titileColor: UIColor = .white
    public var titleAlignment: NSTextAlignment = .center
    public var titleStyle: UIFont.TextStyle = .smilesHeadline5
    public var attributedString: NSMutableAttributedString? = nil
    public var viewDidTapped: (() -> Void)? = nil
}

public protocol Toastable {
    @discardableResult func showToast(model: ToastModel, atPosition position: ToastPosition, _ height: CGFloat) -> ToastView
}

public extension Toastable where Self: UIViewController {
    
    private var currentToastView: ToastView? {
            return view.subviews.compactMap { $0 as? ToastView }.first
        }
    
    @discardableResult
    func showToast(model: ToastModel, atPosition position: ToastPosition = .bottom , _ height: CGFloat = 50.0 ) -> ToastView {
        
        // Check if a toast view is already visible, and if so, return nil
        // If a toast view is already visible, return it
            if let currentToastView = currentToastView {
                return currentToastView
            }
        
        let toastView = ToastView(toastModel: model)
        view.addSubview(toastView)
        
        let isTop = position == .top
        let verticalConstraint = isTop ? toastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0)
        : toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastView.heightAnchor.constraint(equalToConstant: height),
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 16),
            verticalConstraint
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            toastView.removeFromSuperview()
        }
        
        return toastView
    }
}


public enum ToastPosition {
    case top
    case bottom
}

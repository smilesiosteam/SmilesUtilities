//
//  RetryView.swift
//  House
//
//  Created by Faraz Haider on 14/10/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit
import AnalyticsSmiles

protocol RetryViewDelegate {
    func retryButtonClicked(withErrorType: ErrorTypes)
    func dismissButtonClicked()
}

enum ErrorTypes {
    case somethingWrong, paymentFailed, readySoon, noSignal, noSearchResults, customMsg, noFavouriteRestaurants, noFavouriteVouchers, lifestyleSubscriptionFailed
}

class RetryView: UIView {
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var retryButton: UIButton!
    @IBOutlet private var containerView: UIView!
    @IBOutlet var noResultImageTopConstraint: NSLayoutConstraint?
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var actionOnError: UIButton!
    
    var retryDelegate: RetryViewDelegate?
    var errorType: ErrorTypes = .somethingWrong
    
    //    var showRetryButton: Bool {
    //        get { return false }
    //        set { retryButton.isHidden = newValue }
    //    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var newFrame: CGRect = frame
        newFrame.size.height -= frame.origin.y
        //            newFrame.origin.y -= self.frame.origin.y
        containerView.frame = newFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RetryView", owner: self, options: nil)
        addSubview(containerView)
        containerView.bounds = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //
        //        NSLayoutConstraint.activate([
        //                                        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        //                                        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
        //                                        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        //                                        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:
        //        0)])
    }
    
    private func showErrorTextByType(errorType: ErrorTypes, errorMsg: String? = nil, errorTitle: String? = nil, dontShowBackButton: Bool? = false) {
        
        
        self.noResultImageTopConstraint?.constant = 150
        
        retryButton.isHidden = false
        retryButton.setTitle("btn_Retry".localizedString.capitalized, for: .normal)
        actionOnError.isHidden = true
        
        dismissButton.isHidden = false
        
        if let dontShowBackButton = dontShowBackButton, dontShowBackButton {
            dismissButton.isHidden = true
        }
        
        switch errorType {
        case .somethingWrong:
            let analyticsSmiles = AnalyticsSmiles(service: FirebaseAnalyticsService())
            analyticsSmiles.sendAnalyticTracker(trackerData: Tracker(eventType: AnalyticsEvent.firebaseEvent(.FD_Error_generic).name, parameters: [:]))
            
            titleLabel.text = "Something went wrong".localizedString
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "TryingToFixText".localizedString
            }
            errorImageView.image = UIImage(named: "somethingWrong")
        case .readySoon:
            let analyticsSmiles = AnalyticsSmiles(service: FirebaseAnalyticsService())
            analyticsSmiles.sendAnalyticTracker(trackerData: Tracker(eventType: AnalyticsEvent.firebaseEvent(.FD_Error_ready_soon).name, parameters: [:]))
            
            titleLabel.text = "We will be ready soon!".localizedString
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "TryingToFixText".localizedString
            }
            errorImageView.image = UIImage(named: "somethingWrong")
            
        case .paymentFailed:
            let analyticsSmiles = AnalyticsSmiles(service: FirebaseAnalyticsService())
            analyticsSmiles.sendAnalyticTracker(trackerData: Tracker(eventType: AnalyticsEvent.firebaseEvent(.FD_Error_payment_failed).name, parameters: [:]))
            
            titleLabel.text = "paymentFailedTitle".localizedString
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "paymentFailedDesc".localizedString
            }
            errorImageView.image = UIImage(named: "paymentFailed")
            
        case .noSignal:
            let analyticsSmiles = AnalyticsSmiles(service: FirebaseAnalyticsService())
            analyticsSmiles.sendAnalyticTracker(trackerData: Tracker(eventType: AnalyticsEvent.firebaseEvent(.FD_Error_no_internet).name, parameters: [:]))
            
            titleLabel.text = "No signal".localizedString
            detailLabel.text = "NoInternetConnection".localizedString
            errorImageView.image = UIImage(named: "noSignal")
            
        case .noSearchResults:
            self.noResultImageTopConstraint?.constant = -100
            retryButton.isHidden = true
            titleLabel.text = "NoResultsFound".localizedString
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "SorryWeDidNotFind".localizedString
            }
            errorImageView.image = UIImage(named: "no_results_found")
            
        case .noFavouriteRestaurants:
            noResultImageTopConstraint?.constant = 49
            retryButton.isHidden = true
            actionOnError.isHidden = false
            titleLabel.text = "NoFavouriteRestaurants".localizedString
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "NoFavouriteRestaurantsDescription".localizedString
            }
            actionOnError.setTitle("ExploreRestaurants".localizedString, for: .normal)
            errorImageView.image = UIImage(named: "noFavouriteRestaurants")
            self.errorType = .noFavouriteRestaurants
            
        case .noFavouriteVouchers:
            noResultImageTopConstraint?.constant = 49
            retryButton.isHidden = true
            actionOnError.isHidden = false
            titleLabel.text = "NoFavouriteVouchers".localizedString
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "NoFavouriteVouchersDescription".localizedString
            }
            actionOnError.setTitle("ExploreVouchers".localizedString, for: .normal)
            errorImageView.image = UIImage(named: "noVouchers")
            self.errorType = .noFavouriteVouchers
            
        case .customMsg:
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "paymentFailedDesc".localizedString
            }
            if let title = errorTitle, !title.isEmpty {
                titleLabel.text = title
            } else {
                titleLabel.text = "paymentFailedTitle".localizedString
            }
            errorImageView.image = UIImage(named: "paymentFailed")
            retryButton.setTitle("btn_Ok".localizedString.capitalized, for: .normal)
            self.errorType = .customMsg

        case .lifestyleSubscriptionFailed:
            dismissButton.isHidden = true
            if let msg = errorMsg, msg.count > 0 {
                detailLabel.text = msg
            } else {
                detailLabel.text = "paymentFailedDesc".localizedString
            }
            titleLabel.text = "paymentFailedTitle".localizedString
            errorImageView.image = UIImage(named: "paymentFailed")
            retryButton.setTitle("btn_Ok".localizedString.capitalized, for: .normal)
            self.errorType = .lifestyleSubscriptionFailed
        }
        
        self.layoutIfNeeded()
    }
    
    func showErrorWith(errorType: ErrorTypes = .somethingWrong, errorMsg: String? = nil, dontShowBackButton: Bool? = false) {
        DispatchQueue.main.async {
            self.showErrorTextByType(errorType: errorType, errorMsg: errorMsg, dontShowBackButton: dontShowBackButton)
        }
    }
    
    func showErrorWith(errorType: ErrorTypes = .somethingWrong, errorMsg: String? = nil, errorTitle: String? = nil, dontShowBackButton: Bool? = false) {
        DispatchQueue.main.async {
            self.showErrorTextByType(errorType: errorType, errorMsg: errorMsg, errorTitle: errorTitle, dontShowBackButton: dontShowBackButton)
        }
    }
    
    // MARK: - button action
    
    @IBAction private func didSelectRetryButtonAction(_ sender: Any) {
        if retryDelegate != nil {
            retryDelegate?.retryButtonClicked(withErrorType: errorType)
        }
    }
    
    @IBAction func dismissViewController() {
        if retryDelegate != nil {
            retryDelegate?.dismissButtonClicked()
        }
    }
    
    @IBAction private func didSelectActionOnError(_ sender: Any) {
        if retryDelegate != nil {
            retryDelegate?.retryButtonClicked(withErrorType: errorType)
        }
    }
}

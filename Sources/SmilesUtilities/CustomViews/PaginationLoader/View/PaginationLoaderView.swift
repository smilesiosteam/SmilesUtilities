//
//  PaginationLoaderView.swift
//  House
//
//  Created by Muhammad Shayan Zahid on 12/01/2024.
//  Copyright © 2024 Ahmed samir ali. All rights reserved.
//

import UIKit

final public class PaginationLoaderView: UIView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        containerView = view
    }
    
    // MARK: Methods
    func commonInit() {
        _ = Bundle.module.loadNibNamed("PaginationLoaderView", owner: self, options: nil)?.first as? UIView
        addSubview(containerView)
        containerView.frame = bounds
        
        containerView.bindFrameToSuperviewBounds()
    }
    
    public func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "PaginationLoaderView", bundle: Bundle.module)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

//
//  UIScrollView.swift
//  House
//
//  Created by Usman Tarar on 01/10/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit

public enum ScrollPosition: String {
    case top
    case bottom
}

public extension UIScrollView {
    func scrollToPosition(extraScroll: CGFloat = 100 ,animated: Bool, position: ScrollPosition) {
        
        if self.contentSize.height + extraScroll < self.bounds.size.height { return }
        let offset = position == .bottom ? CGPoint(x: 0, y: self.contentSize.height + extraScroll - self.bounds.size.height) : CGPoint(x: 0, y: -contentInset.top)
        self.setContentOffset(offset, animated: animated)
    }
}

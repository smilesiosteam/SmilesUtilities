//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 17/10/2023.
//

import Foundation
import Combine
import UIKit

extension UIButton {
   public var tapPublisher: EventPublisher {
        publisher(for: .touchUpInside)
    }
}

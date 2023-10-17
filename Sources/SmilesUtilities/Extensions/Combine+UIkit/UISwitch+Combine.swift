//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 17/10/2023.
//

import Foundation
import Combine
import UIKit

extension UISwitch {
    var switchPublisher: AnyPublisher<Bool, Never> {
        publisher(for: .valueChanged)
            .map { self.isOn }
            .eraseToAnyPublisher()
    }
}

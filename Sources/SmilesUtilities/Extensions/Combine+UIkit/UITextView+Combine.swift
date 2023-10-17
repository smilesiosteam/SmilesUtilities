//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 17/10/2023.
//

import Foundation
import Combine
import UIKit

extension Publishers {
    
    fileprivate struct EventTextViewPublisher: Publisher {
        
        typealias Output = String
        typealias Failure = Never
        private let textView: UITextView
        
        init(textView: UITextView) {
            self.textView = textView
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, String == S.Input {
            let subscription = EventSubscription<S>()
            subscription.subscriber = subscriber
            textView.delegate = subscription
            subscriber.receive(subscription: subscription)
        }
    }
}


fileprivate class EventSubscription<S: Subscriber>: NSObject, UITextViewDelegate,  Subscription where S.Input == String {
    
    var subscriber: S?
    
    
    func request(_ demand: Subscribers.Demand) {  }
    
    func cancel() {
        subscriber = nil
    }
    
    func textViewDidChange(_ textView: UITextView) {
        _ = subscriber?.receive(textView.text)
    }
}

extension UITextView {
   public var textPublisher: AnyPublisher<String, Never> {
        Publishers
            .EventTextViewPublisher(textView: self)
            .eraseToAnyPublisher()
    }
}


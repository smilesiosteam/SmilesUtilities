//
//  OperatorUtility.swift
//  House
//
//  Created by Ahmed samir ali on 4/29/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import UIKit
import MessageUI
public class OperatorUtility: NSObject, MFMailComposeViewControllerDelegate {

    
    
    //MARK:- Send email
    
    public func sendEmail(email : String, controller : UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])            
           controller.present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    //MARK:- Call
    
    public func callNumber(number : String){
        
        if let url = URL(string: "telprompt://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
            }
        }
    }

    
}


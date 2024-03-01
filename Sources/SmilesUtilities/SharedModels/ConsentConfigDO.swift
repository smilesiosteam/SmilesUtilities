//
//  File.swift
//  
//
//  Created by Habib Rehman on 01/03/2024.
//

import Foundation

// MARK: - Consent
public class ConsentConfigDO: Decodable {
   public  let title: String?
   public  let description: String?
   public  let buttonLeftText: String?
   public  let buttonRightText: String?
    
   public  let consentType: ConsentCategoryType?
}

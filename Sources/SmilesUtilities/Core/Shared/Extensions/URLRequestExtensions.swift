//
//  URLRequestExtensions.swift
//  YayOrNay
//
//  Created by Mahmoud Fathy on 8/3/18.
//  Copyright © 2018 Mahmoud Fathy. All rights reserved.
//

import Foundation
import Alamofire

public extension URLRequest {
    
    mutating func setHeaders(headers: [String: String]?) {
        guard let headers = headers else { return }
        for (headerField,value) in headers {
            addValue(value, forHTTPHeaderField: headerField)
        }
    }
    
}

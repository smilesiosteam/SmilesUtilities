//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 06/11/2023.
//

import Foundation

extension Data {
    public func decoded<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: self)
    }
}

extension Encodable {
    public var toData: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}

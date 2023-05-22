//
//  DecodableExtension.swift
//  House
//
//  Created by Shmeel Ahmed on 13/08/2022.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
public extension Decodable {
    static func fromFile()->Self?{
        if let url = Bundle.main.url(forResource: String(describing: self), withExtension: "json"), let data = try? Data(contentsOf: url), let obj = try? JSONDecoder().decode(Self.self, from: data) {
            return obj
        }
        return nil
    }
}
public extension Encodable{
    func jsonString()->String?{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self){
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

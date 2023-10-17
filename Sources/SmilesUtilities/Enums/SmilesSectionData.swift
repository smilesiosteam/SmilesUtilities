//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 17/10/2023.
//

import Foundation

public protocol SectionIdentifierProtocol {
    var identifier: String { get }
}

public struct TableSectionData<T: SectionIdentifierProtocol> {
    
    public let index: Int
    public let identifier: T
    
}

//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/06/2023.
//

import Foundation

public enum OSMResponseType: String {
    case json = "json"
    case jsonv2 = "jsonv2"
    case xml = "xml"
}

public enum RestaurantFiltersType : Int {
    case filters = 1, deliveryTime = 2
}

public enum FilterDictTags: String {
    case FiltersDict, FiltersForListingsDict
}

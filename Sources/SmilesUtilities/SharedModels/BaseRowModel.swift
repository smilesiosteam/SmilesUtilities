//
//  BaseRowModel.swift
//  House
//
//  Created by Usman Tarar on 27/02/2020.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import UIKit
import Foundation

open class BaseRowModel: NSObject {
    public var rowCellIdentifier = ""
    public var rowValue: Any?
    public var rowTitle: String = ""
    public var rowHeight: CGFloat = UITableView.automaticDimension
    public var rowWidth: CGFloat = UITableView.automaticDimension
    public weak var delegate: AnyObject?
    public var isSelected = false
    public var tag: Int = 0
    public var direction: UICollectionView.ScrollDirection? 
}

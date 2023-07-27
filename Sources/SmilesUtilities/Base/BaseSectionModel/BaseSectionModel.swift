//
//  BaseSectionModel.swift
//  House
//
//  Created by Usman Tarar on 12/03/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
import Foundation

open class BaseSectionModel: NSObject {
    public var sectionCellIdentifier = ""
    public var rowItems: [BaseRowModel] = []
    public var sectionTitle: String = ""
    public var sectionHeight: CGFloat = UITableView.automaticDimension
    public var delegate: Any?
    public var sectionView: UIView?
}

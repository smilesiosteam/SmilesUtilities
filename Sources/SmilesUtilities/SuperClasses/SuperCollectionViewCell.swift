//
//  SuperCollectionViewCell.swift
//  House
//
//  Created by ahmed samir on 9/23/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesLanguageManager

open class SuperCollectionViewCell: UICollectionViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()

        setupStyles()
    }
    
    /* Function added for Rowmodel */
    open func updateCell(rowModel: BaseRowModel) {}

    /* Function added for Rowmodel */
    open func setupStyles() {}
}

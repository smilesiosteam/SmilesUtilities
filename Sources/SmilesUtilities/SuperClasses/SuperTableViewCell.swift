//
//  SuperTableViewCell.swift
//  House
//
//  Created by ahmed samir on 9/23/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//

import UIKit

public class SuperTableViewCell: UITableViewCell {
    public override func awakeFromNib() {
        super.awakeFromNib()
        //        CommonMethods.applyLocalizedStrings(toAllViews: self)
        
        // Initialization code
        setupStyles()
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /* Function added for Rowmodel */
    public func updateCell(rowModel: BaseRowModel) {}
    
    /* Function added for Rowmodel */
    public func setupStyles() {}
}

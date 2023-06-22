//
//  PickerOptionTableViewCell.swift
//  
//
//  Created by Shmeel Ahmed on 19/06/2023.
//

import UIKit

class PickerOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var wrapperVu: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperVu.layer.borderWidth = 1
        wrapperVu.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        wrapperVu.layer.cornerRadius = 10
        
        
        
        icon.layer.borderWidth = 2
        icon.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        icon.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

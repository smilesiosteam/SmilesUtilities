//
//  FiltersCollectionViewCell.swift
//  House
//
//  Created by Shahroze Zaheer on 11/4/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesFontsManager

public struct FiltersCollectionViewCellRevampModel {
    public var name: String = ""
    public var leftImage: String = ""
    public var rightImage: String = ""
    public var isFilterSelected = false
    public var filterValue: String = ""
    public var filterCount: Int?
    public var rightImageWidth: CGFloat = 0
    public var rightImageHeight: CGFloat = 0
    public var tag = 1
    public var rowWidth: Double? = 80
    
    public init(name: String = "", leftImage: String = "", rightImage: String = "", isFilterSelected: Bool = false, filterValue: String = "", filterCount: Int? = nil, rightImageWidth: CGFloat = 0, rightImageHeight: CGFloat = 0, tag: Int = 1, rowWidth: Double? = 80) {
        self.name = name
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.isFilterSelected = isFilterSelected
        self.filterValue = filterValue
        self.filterCount = filterCount
        self.rightImageWidth = rightImageWidth
        self.rightImageHeight = rightImageHeight
        self.tag = tag
        self.rowWidth = rowWidth
    }
}

public class FiltersCollectionViewCellRevamp: UICollectionViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet public weak var filterCountLbl: UILabel! {
        didSet {
            filterCountLbl.fontTextStyle = .smilesBody4
        }
    }
    
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var rightImageView: UIImageView!
    @IBOutlet public weak var roundCornerView: UIView!
    @IBOutlet public weak var rightImageWidthConstraint: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        RoundedViewConrner(cornerRadius: 8)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.appRevampLayerBorderColor.cgColor
        
        titleLabel.fontTextStyle = .smilesBody3
        titleLabel.textColor = .appRevampFilterTextColor
    }
    
    public func updateCell(model: FiltersCollectionViewCellRevampModel) {
        self.titleLabel.text = model.name
        
        self.isSelected = model.isFilterSelected
        
        if isSelected {
            self.layer.borderColor = UIColor.appRevampBorderGrayColor.cgColor
            self.roundCornerView.backgroundColor = UIColor.appRevampEnableStateColor
            self.rightImageView.image = self.rightImageView.image?.withRenderingMode(.alwaysTemplate)
            self.rightImageView.tintColor = UIColor.appRevampFilterTextColor
            self.titleLabel.textColor = .appRevampFilterTextColor
            self.filterCountLbl.backgroundColor = UIColor.appRevampFilterCountBGColor
            self.filterCountLbl.textColor = UIColor.white
        } else {
            self.layer.borderColor = UIColor.appRevampLayerBorderColor.cgColor
            self.backgroundColor = UIColor.appRevampEnableStateColor
            self.roundCornerView.backgroundColor = UIColor.appRevampEnableStateColor
            self.rightImageView.image = self.rightImageView.image?.imageWithColor(color1: .appRevampFilterTextColor)
            self.titleLabel.textColor = .appRevampFilterTextColor
            self.filterCountLbl.backgroundColor = UIColor.appRevampFilterCountBGColor
            self.filterCountLbl.textColor = UIColor.white
        }
        
        if model.rightImageWidth != 0, model.rightImageWidth > 0 {
            rightImageWidthConstraint.constant = model.rightImageWidth
        } else {
            rightImageWidthConstraint.constant = 14
        }
        
        if !model.rightImage.isEmpty {
            rightImageView.image = UIImage(named: model.rightImage)
            rightImageView.isHidden = false
        } else {
            rightImageView.isHidden = true
        }
        
        if model.tag == RestaurantFiltersType.filters.rawValue {
            if let filtersCount = model.filterCount, filtersCount > 0 {
                filterCountLbl.isHidden = false
                
                if self.isSelected {
                    filterCountLbl.addBadge(label: filterCountLbl, badgeCount: "\(filtersCount)", backgroundColor: UIColor.appRevampFilterCountBGColor, textColor: UIColor.white)
                } else {
                    filterCountLbl.addBadge(label: filterCountLbl, badgeCount: "\(filtersCount)", backgroundColor: UIColor.appRevampFilterCountBGColor, textColor: UIColor.white)
                }
            } else {
                filterCountLbl.text = ""
                filterCountLbl.isHidden = true
            }
        } else {
            filterCountLbl.isHidden = true
        }
    }
    
}

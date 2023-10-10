//
//  FiltersTableViewCell.swift
//  House
//
//  Created by Shahroze Zaheer on 11/4/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesFontsManager

public class FiltersTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet public weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet public weak var parentView: UIView!
    @IBOutlet public weak var collectionView: UICollectionView!
    @IBOutlet public weak var title: UILabel! {
        didSet {
            title.textColor = .black
            title.fontTextStyle = .smilesHeadline2
        }
    }
    
    @IBOutlet public weak var subTitle: UILabel! {
        didSet {
            subTitle.textColor = .black.withAlphaComponent(0.8)
            subTitle.fontTextStyle = .smilesBody3
        }
    }
    
    //MARK: - Variables
    public var filtersData: [FiltersCollectionViewCellRevampModel]?{
        didSet{
            self.collectionView?.reloadData()
        }
    }
    public var callBack: ((FiltersCollectionViewCellRevampModel) -> ())?
    
    public static let module = Bundle.module
    
    //MARK: - Cell Lifecycle
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionViewLayout()
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    
    func setupCollectionViewLayout() {
        let flowLayout = RTLCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = flowLayout
        if AppCommonMethods.languageIsArabic() {
            collectionView.semanticContentAttribute = .forceRightToLeft
        }
        collectionView.register(UINib(nibName: String(describing: FiltersCollectionViewCellRevamp.self), bundle: .module), forCellWithReuseIdentifier: String(describing: FiltersCollectionViewCellRevamp.self))
        
    }
    
}

extension FiltersTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtersData?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let data = filtersData?[indexPath.row] {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltersCollectionViewCellRevamp", for: indexPath) as? FiltersCollectionViewCellRevamp else {return UICollectionViewCell()}
            
            cell.updateCell(model: data)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = filtersData?[indexPath.row] {
            callBack?(data)
        }
    }
}

extension FiltersTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let data = filtersData?[indexPath.row], let rowWidth = data.rowWidth {
            return CGSize(width: rowWidth, height: 40.0)
        }
        return CGSize(width: 110.0, height: 40.0)
    }
}

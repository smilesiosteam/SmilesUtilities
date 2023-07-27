//
//  BaseCollectionViewDataSource.swift
//  WeatherTask
//
//  Created by ahmed samir on 3/27/20.
//  Copyright © 2020 ASA. All rights reserved.
//

import UIKit
import Foundation

open class BaseCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    public var collectionViewItems: [BaseRowModel] = []
    public var collectionSectionItems: [BaseSectionModel] = []
    public var dataSourceDelegate: BaseDataSourceDelegate?
    
    // MARK: - Methods
    
    init(dataSource: [BaseRowModel]?, delegate: BaseDataSourceDelegate?) {
        if let object = dataSource {
            collectionViewItems = object
            dataSourceDelegate = delegate
        }
        super.init()
    }
    
    init(dataSourceWithSection: [BaseSectionModel]?, delegate: BaseDataSourceDelegate) {
        if let object = dataSourceWithSection {
            collectionSectionItems = object
            dataSourceDelegate = delegate
        }
        super.init()
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionSectionItems.count > 0 ? collectionSectionItems.count : 1
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionSectionItems.count > 0 {
            return collectionSectionItems[section].rowItems.count
        } else {
            return collectionViewItems.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var item: BaseRowModel = BaseRowModel()

        if collectionSectionItems.count > 0 {
            item = collectionSectionItems[indexPath.section].rowItems[indexPath.row]
        } else {
            item = collectionViewItems[indexPath.row]
        }
        
        // Check Storyboard cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.rowCellIdentifier, for: indexPath) as? SuperCollectionViewCell {
            cell.updateCell(rowModel: item)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionSectionItems.count > 0 {
            let item = collectionSectionItems[indexPath.section].rowItems[indexPath.row]
            let itemValue = item.rowValue
            dataSourceDelegate?.didSelectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
        } else {
            let item = collectionViewItems[indexPath.row]
            let itemValue = item.rowValue
            dataSourceDelegate?.didSelectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionSectionItems.count > 0 {
            let item = collectionSectionItems[indexPath.section].rowItems[indexPath.row]
            let itemValue = item.rowValue
            dataSourceDelegate?.didDeselectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
        } else {
            let item = collectionViewItems[indexPath.row]
            let itemValue = item.rowValue
            dataSourceDelegate?.didDeselectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
        }
    }
    
}

extension BaseCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let item = collectionViewItems[indexPath.row]
//        return CGSize(width: item.rowWidth, height: item.rowHeight)
        var item: BaseRowModel = BaseRowModel()

        if collectionSectionItems.count > 0 {
            item = collectionSectionItems[indexPath.section].rowItems[indexPath.row]
            return CGSize(width: item.rowWidth, height: item.rowHeight)
        } else {
            item = collectionViewItems[indexPath.row]
            return CGSize(width: item.rowWidth, height: item.rowHeight)
        }
        
    }
    
}

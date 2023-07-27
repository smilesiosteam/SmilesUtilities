//
//  BaseTableViewDataSource.swift
//  GenericTableView-etisalat
//
//  Created by Usman Tarar on 01/03/2020.
//  Copyright © 2020 Usman Tarar. All rights reserved.
//

import UIKit
import SmilesUtilities

class BaseTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Var
    
    var tableViewItems: [BaseRowModel] = []
    var tableViewSectionItems: [BaseSectionModel] = []
    var dataSourceDelegate: BaseDataSourceDelegate?
    
    // MARK: - Methods
    
    init(dataSource: [BaseRowModel]?, delegate: BaseDataSourceDelegate?) {
        if let object = dataSource {
            tableViewItems = object
            dataSourceDelegate = delegate
        }
        super.init()
    }
    
    init(dataSourceWithSection: [BaseSectionModel]?, delegate: BaseDataSourceDelegate) {
        if let object = dataSourceWithSection {
            tableViewSectionItems = object
            dataSourceDelegate = delegate
        }
        super.init()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewSectionItems.count > 0 {
            if let items = tableViewSectionItems[safe: indexPath.section], let item = items.rowItems[safe: indexPath.row] {
                if let itemValue = item.rowValue {
                    dataSourceDelegate?.didSelectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
                }
            }
        } else {
            if let item = tableViewItems[safe: indexPath.row] {
                if let itemValue = item.rowValue {
                    dataSourceDelegate?.didSelectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableViewSectionItems.count > 0 {
            if let items = tableViewSectionItems[safe: indexPath.section], let item = items.rowItems[safe: indexPath.row] {
                let itemValue = item.rowValue
                dataSourceDelegate?.didDeselectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
            }
        } else {
            if let item = tableViewItems[safe: indexPath.row] {
                let itemValue = item.rowValue
                dataSourceDelegate?.didDeselectItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        dataSourceDelegate?.scrollViewEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dataSourceDelegate?.viewDidScroll(scrollView)
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableViewSectionItems[section].sectionView {
            return view
        } else {
            return UIView(frame: .zero)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSectionItems.count > 0 ? tableViewSectionItems.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSectionItems.count > 0 ? tableViewSectionItems[section].sectionHeight : CGFloat.zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewSectionItems.count > 0 {
            return tableViewSectionItems[section].rowItems.count
        } else {
            return tableViewItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableViewSectionItems.count > 0 {
            if let item = tableViewSectionItems[indexPath.section].rowItems[safe: indexPath.row] {
                return item.rowHeight
            } else {
                return UITableView.automaticDimension
            }
        } else {
            let item = tableViewItems[indexPath.row]
            return item.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var item = BaseRowModel()
        if tableViewSectionItems.count > 0 {
            if tableViewSectionItems[indexPath.section].rowItems.count > 0 {
                item = tableViewSectionItems[indexPath.section].rowItems[indexPath.row]
            } else {
                return UITableViewCell()
            }
        } else {
            item = tableViewItems[indexPath.row]
        }
        
        // Check Storyboard cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.rowCellIdentifier) as? SuperTableViewCell {
            cell.updateCell(rowModel: item)
            return cell
        }
        
        // Check Nib cell
        if let cellFromNib = tableView.dequeueReusableCell(withIdentifier: item.rowCellIdentifier, for: indexPath) as? SuperTableViewCell {
            cellFromNib.updateCell(rowModel: item)
            return cellFromNib
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSourceDelegate?.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !tableViewSectionItems.isEmpty {
            if let items = tableViewSectionItems[safe: indexPath.section], !items.rowItems.isEmpty {
                if let item = items.rowItems[safe: indexPath.row] {
                    if let itemValue = item.rowValue {
                        dataSourceDelegate?.didSwipeItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
                    }
                }
            }
        } else if !tableViewItems.isEmpty {
            if let item = tableViewItems[safe: indexPath.row] {
                if let itemValue = item.rowValue {
                    dataSourceDelegate?.didSwipeItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
                }
            }
        }
        return dataSourceDelegate?.tableView(tableView, leadingSwipeActionsConfigurationForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !tableViewSectionItems.isEmpty {
            if let items = tableViewSectionItems[safe: indexPath.section], !items.rowItems.isEmpty {
                if let item = items.rowItems[safe: indexPath.row] {
                    if let itemValue = item.rowValue {
                        dataSourceDelegate?.didSwipeItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
                    }
                }
            }
        } else if !tableViewItems.isEmpty {
            if let item = tableViewItems[safe: indexPath.row] {
                if let itemValue = item.rowValue {
                    dataSourceDelegate?.didSwipeItemInRowModel(rowModel: item, rowModelValue: itemValue as Any, atIndexPath: indexPath)
                }
            }
        }
        return dataSourceDelegate?.tableView(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.dataSourceDelegate?.tableView(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
}
    

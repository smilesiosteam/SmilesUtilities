//
//  BaseDataSourceDelegate.swift
//  House
//
//  Created by Ahmed samir ali on 3/10/20.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseDataSourceDelegate {
    func didSelectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath)
    
    func didDeselectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath)
    func scrollViewEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
    func viewDidScroll(_ scrollView: UIScrollView)
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    func didSwipeItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

extension BaseDataSourceDelegate {
    public func didDeselectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {}
    public func scrollViewEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    
    public func viewDidScroll(_ scrollView: UIScrollView) {}
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}
    
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [])
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions:
                  [])
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){}
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    
    public func didSwipeItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {}
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {}

}

protocol UpdateLocationDataSourceDelegate {
    func didSelectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath)
    func didDeselectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath)
    
    func viewDidScroll(_ scrollView: UIScrollView)
    func scrollViewEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
}

extension UpdateLocationDataSourceDelegate {
    func didDeselectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {}
    func viewDidScroll(_ scrollView: UIScrollView) {}
    func scrollViewEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions:
                  [])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}
}

//
//  BaseViewController.swift
//  House
//
//  Created by Usman Tarar on 24/02/2020.
//  Copyright © 2020 Ahmed samir ali. All rights reserved.
//

import UIKit
import Foundation
import SmilesLoader

@objc open class BaseViewController: UIViewController, BaseDataSourceDelegate {
    
    @IBOutlet weak var view_retry: RetryView!
    @IBOutlet weak var view_error: NoContentView!
    var dataSource: BaseTableViewDataSource?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViewUI()
        // Do any additional setup after loading the view.
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        //        self.hideHud()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func styleViewUI(){
        // override in child classes
        
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - data Source
    
    func setUpTableViewDataSource(dataSource: [BaseRowModel], delegate: BaseDataSourceDelegate?, tableView: UITableView) {
        self.dataSource = BaseTableViewDataSource(dataSource: dataSource, delegate: delegate)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.reloadData()
    }
    
    func setUpTableViewSectionsDataSource(dataSource: [BaseSectionModel], delegate: BaseDataSourceDelegate, tableView: UITableView) {
        self.dataSource = BaseTableViewDataSource(dataSourceWithSection: dataSource, delegate: delegate)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.reloadData()
    }
    
    func reloadIndividualSectionOfTableViewOnly(dataSource: [BaseSectionModel], delegate: BaseDataSourceDelegate, tableView: UITableView, sectionNumber:Int) {
        self.dataSource?.tableViewSectionItems[sectionNumber] = dataSource[sectionNumber]
        tableView.reloadSections(IndexSet(integersIn: sectionNumber...sectionNumber), with: .none)
    }
    
    func setUpTableViewDataSourceWithoutscroll(dataSource: [BaseRowModel], delegate: BaseDataSourceDelegate?, tableView: UITableView, offset: CGPoint) {
        self.dataSource = BaseTableViewDataSource(dataSource: dataSource, delegate: delegate)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
        tableView.layer.removeAllAnimations()
        DispatchQueue.main.async {
            tableView.setContentOffset(offset, animated: false)
        }
    }
    
    
    func didSelectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {
        // override in child classes
        
    }
    
    func didDeselectItemInRowModel(rowModel model: BaseRowModel, rowModelValue value: Any, atIndexPath indexPath: IndexPath) {
        // override in child classes
    }
    
    @objc func scrollViewEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // override in child classes
    }
    
    func viewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func refreshViewWithData(){
        
    }
}

// MARK: - Protocol Loadable

protocol Loadable: AnyObject {
    func showHud()
    func hideHud()
}

extension BaseViewController: Loadable {
    func showHud() {
        SmilesLoader.show(with: "LoadingTitle".localizedString)
    }
    
    func hideHud() {
        SmilesLoader.dismiss()
    }
}



extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}

//
//  TableViewExtension.swift
//  House
//
//  Created by Ahmed samir ali on 4/30/19.
//  Copyright © 2019 Ahmed samir ali. All rights reserved.
//
import UIKit

public extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type, withIdentifier reuseIdentifier: String = String(describing: T.self)) {
        register(T.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func registerCellFromNib<T: UITableViewCell>(_ type: T.Type, withIdentifier reuseIdentifier: String = String(describing: T.self), bundle: Bundle? = nil) {
        register(UINib(nibName: String(describing: T.self), bundle: bundle), forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func dequeueCell<T: UITableViewCell>(_ type: T.Type = T.self, withIdentifier reuseIdentifier: String = String(describing: T.self)) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? T else {
            fatalError("Unknown cell type (\(T.self)) for reuse identifier: \(reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name))")
        }
        return cell
    }
    
    public func insert(_ indices: [Int], section: Int = 0, animation: UITableView.RowAnimation = .automatic) {
        guard !indices.isEmpty else { return }
        
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }
        
        beginUpdates()
        insertRows(at: indexPaths, with: animation)
        endUpdates()
    }
    
    public func delete(_ indices: [Int], section: Int = 0, animation: UITableView.RowAnimation = .automatic) {
        guard !indices.isEmpty else { return }
        
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }
        
        beginUpdates()
        deleteRows(at: indexPaths, with: animation)
        endUpdates()
    }
    
    public func reload(_ indices: [Int], section: Int = 0, animation: UITableView.RowAnimation = .automatic) {
        guard !indices.isEmpty else { return }
        
        let indexPaths = indices.map { IndexPath(row: $0, section: section) }
        
        beginUpdates()
        reloadRows(at: indexPaths, with: animation)
        endUpdates()
    }
}

// MARK: - IndexPathTraversing

public extension UITableView {
    public var minimumIndexPath: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    public var maximumIndexPath: IndexPath {
        let lastSection = max(0, numberOfSections - 1)
        let lastRow = max(0, numberOfRows(inSection: lastSection) - 1)
        return IndexPath(row: lastRow, section: lastSection)
    }
    
    public func indexPath(after indexPath: IndexPath) -> IndexPath? {
        if indexPath == self.maximumIndexPath {
            return nil
        }
        
        self.assertIsValid(indexPath: indexPath)
        
        let lastRow = numberOfRows(inSection: indexPath.section)
        if indexPath.item == lastRow {
            return IndexPath(row: 0, section: indexPath.section + 1)
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    public func indexPath(before indexPath: IndexPath) -> IndexPath? {
        if indexPath == self.minimumIndexPath {
            return nil
        }
        
        self.assertIsValid(indexPath: indexPath)
        
        if indexPath.item == 0 {
            let lastRow = numberOfRows(inSection: indexPath.section - 1)
            return IndexPath(row: lastRow, section: indexPath.section - 1)
        } else {
            return IndexPath(row: indexPath.row - 1, section: indexPath.section)
        }
    }
    
    private func assertIsValid(indexPath: IndexPath, file: StaticString = #file, line: UInt = #line) {
        let maxPath = self.maximumIndexPath
        assert(
            indexPath.section <= maxPath.section && indexPath.section >= 0,
            "Index path \(indexPath) is outside the bounds set by the minimum (\(self.minimumIndexPath)) and maximum (\(maxPath)) index path",
            file: file,
            line: line
        )
        let rowCount = numberOfRows(inSection: indexPath.section)
        assert(
            indexPath.row < rowCount && indexPath.row >= 0,
            "Index path \(indexPath) row index is outside the bounds of the rows (\(rowCount)) in the indexPath's section",
            file: file,
            line: line
        )
    }
}

public extension UITableViewCell {
    var tableView: UITableView? {
        return next(of: UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}

public extension UIImage {
    func flipHorizontally() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.translateBy(x: self.size.width / 2, y: self.size.height / 2)
        context.scaleBy(x: -1.0, y: 1.0)
        context.translateBy(x: -self.size.width / 2, y: -self.size.height / 2)
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

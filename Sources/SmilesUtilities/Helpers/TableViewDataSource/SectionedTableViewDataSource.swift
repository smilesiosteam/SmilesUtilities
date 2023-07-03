//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 03/07/2023.
//

import UIKit

public class SectionedTableViewDataSource: NSObject {
    
    public var dataSources: [Any]?
    public var selectedIndexPath: IndexPath?

    public init(dataSources: [Any]?) {
        self.dataSources = dataSources
    }
    
}


extension SectionedTableViewDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources?.count ?? 0
    }

    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let dataSource = dataSources?[safe: section] as? UITableViewDataSource
        return dataSource?.tableView(tableView, numberOfRowsInSection: 0) ?? 0
    }

    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = dataSources?[safe: indexPath.section] as? UITableViewDataSource
        let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
        return dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }

}

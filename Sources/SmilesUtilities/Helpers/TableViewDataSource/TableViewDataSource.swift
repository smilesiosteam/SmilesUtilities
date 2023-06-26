//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 26/06/2023.
//

import Foundation
import SkeletonView
import UIKit

public class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
    public var isDummy = false
    public typealias CellConfigurator = (Model, UITableViewCell, String, IndexPath?) -> Void
    public var models: [Model]?
    public var data : String
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    public init(models: [Model],
         reuseIdentifier: String,
         data:String,
         isDummy:Bool = false,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
        self.data = data
        self.isDummy = isDummy
    }
    
    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models?[safe: indexPath.row] else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        cellConfigurator(model, cell, data, indexPath)
        DispatchQueue.main.async {
            if self.isDummy {
                cell.enableSkeleton()
                cell.showAnimatedSkeleton()
            } else {
                cell.hideSkeleton()
            }
            self.cellConfigurator(model, cell, self.data, indexPath)
        }
        return cell
    }
}

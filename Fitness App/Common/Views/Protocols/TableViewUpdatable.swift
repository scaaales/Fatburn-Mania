//
//  TableViewUpdatable.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol TableViewUpdatable {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}

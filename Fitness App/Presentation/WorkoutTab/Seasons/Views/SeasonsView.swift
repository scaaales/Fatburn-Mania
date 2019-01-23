//
//  SeasonsView.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol SeasonsView: View {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}

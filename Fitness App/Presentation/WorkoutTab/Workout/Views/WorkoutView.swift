//
//  WorkoutView.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol WorkoutView: View {
	func update()
	func setSegments(titles: [String])
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}


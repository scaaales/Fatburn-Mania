//
//  CourseVideosView.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol CourseVideosView: View {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}

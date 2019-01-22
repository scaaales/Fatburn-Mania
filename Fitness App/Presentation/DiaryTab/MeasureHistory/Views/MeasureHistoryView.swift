//
//  MeasureHistoryView.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol MeasureHistoryView: View {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}

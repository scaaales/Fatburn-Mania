//
//  CoinsHistoryView.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol CoinsHistoryView: View {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}

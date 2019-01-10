//
//  ProfileView.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol ProfileView: View {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
}

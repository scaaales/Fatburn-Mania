//
//  UITableView+resizable.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UITableView {
	func makeResizable() {
		estimatedSectionHeaderHeight = 1
		sectionHeaderHeight = UITableView.automaticDimension
		
		estimatedRowHeight = 1
		rowHeight = UITableView.automaticDimension
		
		estimatedSectionFooterHeight = 1
		sectionFooterHeight = UITableView.automaticDimension
	}
}

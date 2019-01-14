//
//  UITableView+resizable.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UITableView {
	func makeResizable(header: Bool = true, cell: Bool = true, footer: Bool = true) {
		if header {
			estimatedSectionHeaderHeight = .leastNormalMagnitude
			sectionHeaderHeight = UITableView.automaticDimension
		}
		
		if cell {
			estimatedRowHeight = 1
			rowHeight = UITableView.automaticDimension
		}
		
		if footer {
			estimatedSectionFooterHeight = 1
			sectionFooterHeight = UITableView.automaticDimension
		}
	}
}

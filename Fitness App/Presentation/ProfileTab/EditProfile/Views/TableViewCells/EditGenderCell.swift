//
//  EditGenderCell.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditGenderCell: UITableViewCell, ConfigurableCell {
	typealias DataType = User.Gender
	
	@IBOutlet private weak var segmentedControl: UISegmentedControl!
	
	func configure(data: User.Gender) {
		if data == .male {
			segmentedControl.selectedSegmentIndex = 1
		} else {
			segmentedControl.selectedSegmentIndex = 0
		}
		
		let normalTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold),
									NSAttributedString.Key.foregroundColor: UIColor.black]
		let selectedTextAttirbutes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold),
									  NSAttributedString.Key.foregroundColor: UIColor.white]
		
		segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
		segmentedControl.setTitleTextAttributes(selectedTextAttirbutes, for: .selected)
	}
	
}

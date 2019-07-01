//
//  EditGenderCell.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditGenderCell: UITableViewCell, ConfigurableCell {
	typealias DataType = (gender: User.Gender?, updateHandler: (User.Gender) -> Void)
	
	@IBOutlet private weak var segmentedControl: UISegmentedControl!
	private var updateHandler: ((User.Gender) -> Void)!
	
	func configure(data: DataType) {
		if let gender = data.gender {
			if gender == .male {
				segmentedControl.selectedSegmentIndex = 1
			} else {
				segmentedControl.selectedSegmentIndex = 0
			}
		} else {
			segmentedControl.selectedSegmentIndex = -1
		}
		
		let normalTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold),
									NSAttributedString.Key.foregroundColor: UIColor.black]
		let selectedTextAttirbutes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold),
									  NSAttributedString.Key.foregroundColor: UIColor.white]
		
		segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
		segmentedControl.setTitleTextAttributes(selectedTextAttirbutes, for: .selected)
		
		self.updateHandler = data.updateHandler
		guard let actions = segmentedControl.actions(forTarget: self, forControlEvent: .valueChanged) else {
			addAction()
			return
		}
		if actions.isEmpty {
			addAction()
		}
	}
	
	private func addAction() {
		segmentedControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
	}
	
	@objc private func valueChanged() {
		let index = segmentedControl.selectedSegmentIndex
		let gender: User.Gender
		if index == 0 {
			gender = .female
		} else {
			gender = .male
		}
		updateHandler(gender)
	}
	
}

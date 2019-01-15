//
//  EditProfileView.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol EditProfileView: View, UITextFieldDelegate {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
	func getViewForDateInput() -> UIDatePicker
	func getHelperViewForDateInput() -> UIView
}

//
//  EditProfileView.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol EditProfileView: View, UITextFieldDelegate, TableViewUpdatable {
	func getViewForDateInput() -> UIDatePicker
	func getHelperViewForDateInput() -> UIView
}

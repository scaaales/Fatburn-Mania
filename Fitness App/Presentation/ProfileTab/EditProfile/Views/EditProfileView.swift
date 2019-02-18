//
//  EditProfileView.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol EditProfileView: View, TableViewUpdatable {
	var textFieldDelegate: UITextFieldDelegate { get }
	var helperView: UIView { get }
	var viewForDateInput: UIDatePicker { get }
}

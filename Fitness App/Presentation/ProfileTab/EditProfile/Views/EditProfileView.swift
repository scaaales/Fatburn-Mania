//
//  EditProfileView.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol EditProfileView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	var textFieldDelegate: UITextFieldDelegate { get }
	var helperView: UIView { get }
	var viewForDateInput: UIDatePicker { get }
	
	var viewControllerToPresentPicker: UIViewController { get }
	func setPhoto(_ image: UIImage) 
	
	func closeItself()
}

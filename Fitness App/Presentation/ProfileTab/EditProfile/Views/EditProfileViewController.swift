//
//  EditProfileViewController.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController {
	var presenter: EditProfilePresenter<EditProfileViewController>!
	
	private var textFieldAssistant: TextFieldAssistant!
	private let firstResponderTag = 100
	private let lastResponderTag = 110
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		textFieldAssistant = .init(view: view, firstResponderTag: firstResponderTag, lastResponderTag: lastResponderTag)
		presenter.getUser()
		tableView.backgroundColor = .white
	}
	
}

extension EditProfileViewController: EditProfileView {
	var textFieldDelegate: UITextFieldDelegate {
		return textFieldAssistant
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func getViewForDateInput() -> UIDatePicker {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.setDate(presenter.getBirthdayDate(), animated: false)
		return datePicker
	}
}


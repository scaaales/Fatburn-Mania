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
	private let lastResponderTag = 109
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		textFieldAssistant = .init(view: view, firstResponderTag: firstResponderTag, lastResponderTag: lastResponderTag)
		textFieldAssistant.makeFirstResponderDelegate = self
		presenter.getUser()
		tableView.backgroundColor = .white
	}
	
}

extension EditProfileViewController: EditProfileView {
	var helperView: UIView {
		return textFieldAssistant.textViewHelperView
	}
	
	var viewForDateInput: UIDatePicker {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.setDate(presenter.getBirthdayDate(), animated: false)
		return datePicker
	}
	
	var textFieldDelegate: UITextFieldDelegate {
		return textFieldAssistant
	}
	
	func update() {
		tableView.reloadData()
		textFieldAssistant = .init(view: tableView, firstResponderTag: firstResponderTag, lastResponderTag: lastResponderTag)
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
}

extension EditProfileViewController: MakeFirstResponderDelegate {
	func makeFirstResponder(with tag: Int) {
		let row: Int
		if tag > 107 {
			row = tag - 99
		} else {
			row = tag - 100
		}
		let cell = tableView.cellForRow(at: .init(row: row, section: 0))
		cell?.becomeFirstResponder()
	}
	
}

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
	
	private var currentResponderTag: Int! {
		didSet {
			if currentResponderTag == firstResponderTag {
				textViewHelperView.disablePrevButton()
			} else if currentResponderTag == lastResponderTag {
				textViewHelperView.disableNextButton()
			}
		}
	}
	private let firstResponderTag = 100
	private var lastResponderTag = 110
	
	private var textViewHelperView: TextViewHelperView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		presenter.getUser()
		tableView.backgroundColor = .white
	}
	
	private func makeFirstResponderView(with tag: Int) {
		let nextResponderView = self.view.viewWithTag(tag)
		nextResponderView?.becomeFirstResponder()
	}
}

extension EditProfileViewController: EditProfileView {
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
	
	func getHelperViewForDateInput() -> UIView {
		textViewHelperView = TextViewHelperView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
		textViewHelperView.setHandlers(prevHandler: { [weak self] in
			guard let self = self else { return }
			let nextResponderTag = self.currentResponderTag - 1
			self.makeFirstResponderView(with: nextResponderTag)
		}, nextHandler: { [weak self] in
			guard let self = self else { return }
			let nextResponderTag = self.currentResponderTag + 1
			self.makeFirstResponderView(with: nextResponderTag)
		}, doneHandler: { [weak self] in
			self?.view.endEditing(true)
		})
		return textViewHelperView
	}
	
}

extension EditProfileViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField.tag == lastResponderTag {
			view.endEditing(true)
			return true
		} else {
			let nextResponderTag = textField.tag + 1
			makeFirstResponderView(with: nextResponderTag)
			return false
		}
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		currentResponderTag = textField.tag
	}
}


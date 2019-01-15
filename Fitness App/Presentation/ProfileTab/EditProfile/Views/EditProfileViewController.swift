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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		presenter.getUser()
		tableView.backgroundColor = .white
	}
	
}

extension EditProfileViewController: EditProfileView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	
}

extension EditProfileViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField.tag == 110 {
			view.endEditing(true)
			return true
		} else {
			tableView.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
			return false
		}
		
	}
}


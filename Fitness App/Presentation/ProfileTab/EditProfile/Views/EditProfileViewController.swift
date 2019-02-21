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
	
	private func getCellAtRow(_ row: Int) -> UITableViewCell? {
		let indexPath = IndexPath(item: row, section: 0)
		return tableView.cellForRow(at: indexPath)
	}
	
	@IBAction private func saveTapped() {
		presenter.saveChanges()
	}
	
}

extension EditProfileViewController: EditProfileView {
	var avatar: UIImage? {
		let header = tableView.tableHeaderView
		guard let imageView = header?.subviews.first(where: { $0 is UIImageView }) as? UIImageView else { return nil }
		return imageView.image
	}

//	var firstName: String {
//		guard let cell = getCellAtRow(0) as? EditProfileDataCell else { return "" }
//		return cell.textFieldText ?? ""
//	}
//
//	var lastName: String? {
//		guard let cell = getCellAtRow(1) as? EditProfileDataCell else { return nil }
//		return cell.textFieldText
//	}
//
//	var nickname: String? {
//		guard let cell = getCellAtRow(2) as? EditProfileDataCell else { return nil }
//		return cell.textFieldText
//	}
//
//	var instagram: String? {
//		guard let cell = getCellAtRow(3) as? EditProfileDataCell else { return nil }
//		return cell.textFieldText ?? ""
//	}
//
//	var country: String? {
//		guard let cell = getCellAtRow(4) as? EditProfileDataCell else { return nil }
//		return cell.textFieldText ?? ""
//	}
//
//	var city: String? {
//		guard let cell = getCellAtRow(5) as? EditProfileDataCell else { return nil }
//		return cell.textFieldText ?? ""
//	}
//
//	var dateOfBirth: Date? {
//		guard let cell = getCellAtRow(7) as? EditProfileDataCell,
//			let text = cell.textFieldText else { return nil }
//		let dateFormatter = DateFormatter()
//		dateFormatter.dateFormat = "dd MMMM yyyy"
//
//		return dateFormatter.date(from: text)
//	}
//
//	var gender: User.Gender? {
//		guard let cell = getCellAtRow(8) as? EditGenderCell else { return nil }
//		let selectedIndex = cell.segmentedControlIndex
//		if selectedIndex == 0 {
//			return .female
//		} else if selectedIndex == 1 {
//			return .male
//		} else {
//			return nil
//		}
//	}
//
//	var phone: String {
//		guard let cell = getCellAtRow(9) as? EditProfileDataCell else { return "" }
//		return cell.textFieldText ?? ""
//	}
//
//	var email: String {
//		guard let cell = getCellAtRow(10) as? EditProfileDataCell else { return "" }
//		return cell.textFieldText ?? ""
//	}
//
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

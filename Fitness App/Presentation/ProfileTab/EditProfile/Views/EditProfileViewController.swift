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
	private let lastResponderTag = 108
	var profileViewController: ProfileViewController!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
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
	
	@IBAction private func addAvatarTapped() {
		presenter.addPhoto()
	}
	
}

extension EditProfileViewController: EditProfileView {
	func setPhoto(_ image: UIImage) {
		let header = tableView.tableHeaderView
		guard let imageView = header?.subviews.first(where: { $0 is UIImageView }) as? UIImageView,
			let button = header?.subviews.first(where: { $0 is UIButton }) as? UIButton else { return }
		imageView.image = image
		button.setImage(.init(), for: .normal)
	}
	
	var viewControllerToPresentPicker: UIViewController { return self }
	
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}

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
	
	func closeItself() {
		profileViewController.presenter.updateUser(with: presenter.user)
		navigationController?.popViewController(animated: true)
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

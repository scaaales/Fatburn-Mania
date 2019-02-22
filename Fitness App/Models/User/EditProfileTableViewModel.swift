//
//  EditProfileTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditProfileTableViewModel: NSObject {
	private typealias EditProfileDataCellConfigurator = CellsConfigurator<EditProfileDataCell, EditProfileCellType>
	private typealias EditGenderCellConfigurator = CellsConfigurator<EditGenderCell, EditGenderCell.DataType>
	
	private var rows: [CellConfigurator] {
		var rows = [CellConfigurator]()
	
		rows.append(contentsOf: getFirstRows(from: user,
											 textFieldDelegate: textFieldDelegate,
											 datePickerView: datePickerView,
											 helperView: helperView))
		rows.append(EditGenderCellConfigurator(item: (gender: user.gender,
													  updateHandler: { [weak self] in self?.user.setGender($0) })))
		rows.append(contentsOf: getLastRows(from: user,
											textFieldDelegate: textFieldDelegate,
											helperView: helperView))
		return rows
	}
	private(set) var user: User
	private let textFieldDelegate: UITextFieldDelegate
	private let datePickerView: UIDatePicker?
	private let helperView: UIView
	
	init(user: User, textFieldDelegate: UITextFieldDelegate, datePickerView: UIDatePicker?, helperView: UIView) {
		self.user = user
		self.textFieldDelegate = textFieldDelegate
		self.datePickerView = datePickerView
		self.helperView = helperView
		super.init()
	}
	
	private func getFirstRows(from user: User, textFieldDelegate: UITextFieldDelegate, datePickerView: UIDatePicker?, helperView: UIView) -> [CellConfigurator] {
		let items = [EditProfileCellType(fieldName: "First name",
										 value: user.firstName,
										 textType: .givenName,
										 delegate: textFieldDelegate,
										 tag: 100,
										 dateInputView: nil,
										 helperView: helperView) { [weak self] in self?.user.firstName = $0 ?? "" },
					 EditProfileCellType(fieldName: "Second name",
										 value: user.lastName,
										 textType: .familyName,
										 delegate: textFieldDelegate,
										 tag: 101,
										 dateInputView: nil,
										 helperView: helperView) { [weak self] in self?.user.lastName = $0 },
					 EditProfileCellType(fieldName: "Nickname",
										 value: user.nickname,
										 textType: .nickname,
										 delegate: textFieldDelegate,
										 tag: 102,
										 dateInputView: nil,
										 helperView: helperView) { [weak self] in self?.user.nickname = $0 },
					 EditProfileCellType(fieldName: "Instagram profile",
										 value: user.instagram,
										 textType: nil,
										 delegate: textFieldDelegate,
										 tag: 103,
										 dateInputView: nil,
										 helperView: helperView) { [weak self] in self?.user.instagram = $0 },
					 EditProfileCellType(fieldName: "Country",
										 value: user.country,
										 textType: .countryName,
										 delegate: textFieldDelegate,
										 tag: 104,
										 dateInputView: nil,
										 helperView: helperView) { [weak self] in self?.user.country = $0 },
					 EditProfileCellType(fieldName: "City",
										 value: user.city,
										 textType: .addressCity,
										 delegate: textFieldDelegate,
										 tag: 105,
										 dateInputView: nil,
										 helperView: helperView) { [weak self] in self?.user.city = $0 },
					 EditProfileCellType(fieldName: "Password to vote",
										 value: "asd71623bhas",
										 textType: nil,
										 delegate: textFieldDelegate,
										 tag: 106,
										 dateInputView: nil,
										 helperView: helperView) { _ in },
					 EditProfileCellType(fieldName: "Date of Birth",
										 value: user.dateOfBirthFormatted,
										 textType: nil,
										 delegate: textFieldDelegate,
										 tag: 107,
										 dateInputView: datePickerView,
										 helperView: helperView) { [weak self] in
											let formatter = DateFormatter()
											formatter.dateFormat = "dd MMMM yyyy"
											if let dateString = $0,
												let date = formatter.date(from: dateString) {
												self?.user.setDateOfBirth(from: date)
											}
			}]
		return items.map { EditProfileDataCellConfigurator(item: $0) }
	}
	
	private func getLastRows(from user: User, textFieldDelegate: UITextFieldDelegate, helperView: UIView) -> [CellConfigurator] {
		let items: [EditProfileDataCell.DataType] = [EditProfileCellType(fieldName: "Phone",
																		 value: user.phone,
																		 textType: .telephoneNumber,
																		 delegate: textFieldDelegate,
																		 tag: 108,
																		 dateInputView: nil,
																		 helperView: helperView) { [weak self] in self?.user.phone = $0 ?? "" },
													 EditProfileCellType(fieldName: "Email",
																		 value: user.email,
																		 textType: .emailAddress,
																		 delegate: textFieldDelegate,
																		 tag: 109,
																		 dateInputView: nil,
																		 helperView: helperView) { [weak self] in self?.user.email = $0 ?? "" }]
		return items.map { EditProfileDataCellConfigurator(item: $0) }
	}
	
}

extension EditProfileTableViewModel: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return rows.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = rows[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseId, for: indexPath)
		item.configure(cell: cell)
		
		return cell
	}
}

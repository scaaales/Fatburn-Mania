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
	private typealias EditGenderCellConfigurator = CellsConfigurator<EditGenderCell, User.Gender?>
	
	private var rows: [CellConfigurator]
	
	init(user: User, textFieldDelegate: UITextFieldDelegate, datePickerView: UIDatePicker?, helperView: UIView) {
		rows = []
		super.init()
		rows.append(contentsOf: getFirstRows(from: user,
											 textFieldDelegate: textFieldDelegate,
											 datePickerView: datePickerView,
											 helperView: helperView))
		rows.append(EditGenderCellConfigurator(item: user.gender))
		rows.append(contentsOf: getLastRows(from: user,
											textFieldDelegate: textFieldDelegate,
											helperView: helperView))
	}
	
	private func getFirstRows(from user: User, textFieldDelegate: UITextFieldDelegate, datePickerView: UIDatePicker?, helperView: UIView) -> [CellConfigurator] {
		let items = [EditProfileCellType(fieldName: "First name",
										 value: user.firstName,
										 textType: .givenName,
										 delegate: textFieldDelegate,
										 tag: 100,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "Second name",
										 value: user.lastName,
										 textType: .familyName,
										 delegate: textFieldDelegate,
										 tag: 101,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "Nickname",
										 value: user.nickname,
										 textType: .nickname,
										 delegate: textFieldDelegate,
										 tag: 102,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "Instagram profile",
										 value: user.instagram,
										 textType: nil,
										 delegate: textFieldDelegate,
										 tag: 103,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "Country",
										 value: user.country,
										 textType: .countryName,
										 delegate: textFieldDelegate,
										 tag: 104,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "City",
										 value: user.city,
										 textType: .addressCity,
										 delegate: textFieldDelegate,
										 tag: 105,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "Password to vote",
										 value: "asd71623bhas",
										 textType: nil,
										 delegate: textFieldDelegate,
										 tag: 106,
										 dateInputView: nil,
										 helperView: helperView),
					 EditProfileCellType(fieldName: "Date of Birth",
										 value: user.dateOfBirthFormatted,
										 textType: nil,
										 delegate: textFieldDelegate,
										 tag: 107,
										 dateInputView: datePickerView,
										 helperView: helperView)]
		return items.map { EditProfileDataCellConfigurator(item: $0) }
	}
	
	private func getLastRows(from user: User, textFieldDelegate: UITextFieldDelegate, helperView: UIView) -> [CellConfigurator] {
		let items: [EditProfileDataCell.DataType] = [EditProfileCellType(fieldName: "Phone",
																		 value: user.phone,
																		 textType: .telephoneNumber,
																		 delegate: textFieldDelegate,
																		 tag: 108,
																		 dateInputView: nil,
																		 helperView: helperView),
													 EditProfileCellType(fieldName: "Email",
																		 value: user.email,
																		 textType: .emailAddress,
																		 delegate: textFieldDelegate,
																		 tag: 109,
																		 dateInputView: nil,
																		 helperView: helperView)]
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

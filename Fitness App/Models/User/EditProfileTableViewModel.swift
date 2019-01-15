//
//  EditProfileTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditProfileTableViewModel: NSObject {
	private typealias EditProfileDataCellConfigurator = CellsConfigurator<EditProfileDataCell, EditProfileDataCell.DataType>
	private typealias EditGenderCellConfigurator = CellsConfigurator<EditGenderCell, User.Gender>
	
	private var rows: [CellConfigurator]
	
	init(user: User, textFieldDelegate: UITextFieldDelegate) {
		rows = []
		super.init()
		rows.append(contentsOf: getFirstRows(from: user, textFieldDelegate: textFieldDelegate))
		rows.append(EditGenderCellConfigurator(item: user.gender))
		rows.append(contentsOf: getLastRows(from: user, textFieldDelegate: textFieldDelegate))
	}
	
	private func getFirstRows(from user: User, textFieldDelegate: UITextFieldDelegate) -> [CellConfigurator] {
		let items: [EditProfileDataCell.DataType] = [(fieldName: "First name", value: user.firstName, textType: .givenName, delegate: textFieldDelegate, tag: 100),
					 (fieldName: "Second name", value: user.lastName, textType: .familyName, delegate: textFieldDelegate, tag: 101),
					 (fieldName: "Nickname", value: user.nickname, textType: .nickname, delegate: textFieldDelegate, tag: 102),
					 (fieldName: "Instagram profile", value: user.instagramName, textType: nil, delegate: textFieldDelegate, tag: 103),
					 (fieldName: "Country", value: user.country, textType: .countryName, delegate: textFieldDelegate, tag: 104),
					 (fieldName: "City", value: user.city, textType: .addressCity, delegate: textFieldDelegate, tag: 105),
					 (fieldName: "Your ID", value: "65571", textType: nil, delegate: textFieldDelegate, tag: 106),
					 (fieldName: "Password to vote", value: "asd71623bhas", textType: nil, delegate: textFieldDelegate, tag: 107),
					 (fieldName: "Date of Birth", value: user.dateOfBirthFormatted, textType: nil, delegate: textFieldDelegate, tag: 108)]
		return items.map { EditProfileDataCellConfigurator(item: $0) }
	}
	
	private func getLastRows(from user: User, textFieldDelegate: UITextFieldDelegate) -> [CellConfigurator] {
		let items: [EditProfileDataCell.DataType] = [(fieldName: "Phone", value: "+3 (8097) 419-6416", textType: .telephoneNumber, delegate: textFieldDelegate, tag: 109),
													 (fieldName: "Email", value: "sergey.kletsov@outlook.com", textType: .emailAddress, delegate: textFieldDelegate, tag: 110)]
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

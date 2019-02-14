//
//  EditProfileDataCell.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditProfileDataCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = EditProfileCellType
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var valueTextField: UITextField!
	
	func configure(data: EditProfileCellType) {
		titleLabel.text = data.fieldName
		valueTextField.text = data.value
		valueTextField.textContentType = data.textType
		valueTextField.delegate = data.delegate
		valueTextField.tag = data.tag
		valueTextField.inputView = data.dateInputView
		if let datePicker = data.dateInputView {
			datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: .valueChanged)
		}
	}
	
	@objc func dateSelected(datePicker: UIDatePicker) {
		let date = datePicker.date
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMMM yyyy"
		valueTextField.text = formatter.string(from: date)
	}

}

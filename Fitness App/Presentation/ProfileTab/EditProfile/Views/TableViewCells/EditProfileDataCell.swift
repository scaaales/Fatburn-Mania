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
	private var updateHandler: ((String?) -> Void)!
	
	func configure(data: EditProfileCellType) {
		titleLabel.text = data.fieldName
		valueTextField.text = data.value
		valueTextField.textContentType = data.textType
		valueTextField.delegate = data.delegate
		valueTextField.tag = data.tag
		valueTextField.inputView = data.dateInputView
		valueTextField.inputAccessoryView = data.helperView
		if let datePicker = data.dateInputView {
			datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: .valueChanged)
		}
		
		self.updateHandler = data.updateHandler
		guard let actions = valueTextField.actions(forTarget: self, forControlEvent: .editingChanged) else {
			addAction()
			return
		}
		if actions.isEmpty {
			addAction()
		}
	}
	
	@objc private func dateSelected(datePicker: UIDatePicker) {
		let date = datePicker.date
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMMM yyyy"
		valueTextField.text = formatter.string(from: date)
		updateHandler(valueTextField.text)
	}
	
	private func addAction() {
		valueTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
	}
	
	@objc private func editingChanged() {
		updateHandler(valueTextField.text)
	}
	
	override func becomeFirstResponder() -> Bool {
		valueTextField.becomeFirstResponder()
		return super.becomeFirstResponder()
	}

}

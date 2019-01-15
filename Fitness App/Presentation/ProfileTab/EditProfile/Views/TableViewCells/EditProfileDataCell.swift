//
//  EditProfileDataCell.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class EditProfileDataCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = (fieldName: String, value: String, textType: UITextContentType?, delegate: UITextFieldDelegate, tag: Int)
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var valueTextField: UITextField!
	
	func configure(data: DataType) {
		titleLabel.text = data.fieldName
		valueTextField.text = data.value
		valueTextField.textContentType = data.textType
		valueTextField.delegate = data.delegate
		valueTextField.tag = data.tag
	}

}

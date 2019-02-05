//
//  LineTextField.swift
//  Fitness App
//
//  Created by scales on 1/4/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class LineTextField: UIView {
	
	@IBOutlet private weak var textField: UITextField!
	@IBOutlet private var line: UIView!
	var text: String? {
		return textField.text
	}
	
	func setDelegate(_ delegate: UITextFieldDelegate) {
		textField.delegate = delegate
	}
	
	func setErrorState(errorTitle: String) {
		textField.textColor = .redErrorColor
		line.backgroundColor = .redErrorColor
		textField.text = errorTitle
		textField.isSecureTextEntry = false
	}
	
	func setNormalState(isSecure: Bool = false) {
		textField.textColor = .grayNormalColor
		line.backgroundColor = .lightGrayColor
		textField.text = ""
		textField.isSecureTextEntry = isSecure
	}
	
	func activateTextField() {
		textField.becomeFirstResponder()
	}
	
	func setInputAccessoryView(_ view: UIView) {
		textField.inputAccessoryView = view
	}
	
}

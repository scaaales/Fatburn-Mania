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
		return isNormalState ? textField.text : nil
	}
	private var isNormalState = true
	
	func setDelegate(_ delegate: UITextFieldDelegate) {
		textField.delegate = delegate
	}
	
	func setErrorState(errorTitle: String) {
		textField.textColor = .redErrorColor
		line.backgroundColor = .redErrorColor
		textField.text = errorTitle
		textField.isSecureTextEntry = false
		isNormalState = false
	}
	
	func setNormalState(isSecure: Bool = false) {
		if isNormalState { return }
		textField.textColor = .black
		line.backgroundColor = .lightGrayColor
		textField.text = ""
		textField.isSecureTextEntry = isSecure
		isNormalState = true
	}
	
	func activateTextField() {
		textField.becomeFirstResponder()
	}
	
	func setInputAccessoryView(_ view: UIView) {
		textField.inputAccessoryView = view
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		return textField.isEqual(object)
	}
	
}

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
	private(set) var isNormalState = true
	
	func setDelegate(_ delegate: UITextFieldDelegate) {
		textField.delegate = delegate
	}
	
	func setErrorState(errorTitle: String?, isSecure: Bool = false) {
		textField.textColor = .redErrorColor
		line.backgroundColor = .redErrorColor
		if let errorTitle = errorTitle {
			textField.text = errorTitle
			isNormalState = false
		}
		textField.isSecureTextEntry = false
		textField.isSecureTextEntry = isSecure
	}
	
	func setNormalState(isSecure: Bool = false) {
		textField.textColor = .black
		line.backgroundColor = .lightGrayColor
		textField.isSecureTextEntry = isSecure
		isNormalState = true
	}
	
	func activateTextField() {
		textField.becomeFirstResponder()
	}
	
	func setInputAccessoryView(_ view: UIView) {
		textField.inputAccessoryView = view
	}
	
	func clearOnNextEditing(_ value: Bool) {
		textField.clearsOnBeginEditing = value
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		return textField.isEqual(object)
	}
	
}

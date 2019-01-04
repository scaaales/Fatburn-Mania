//
//  SignInViewController.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
	var presenter: SignInPresenter<SignInViewController>!
	
	@IBOutlet private weak var nameTextField: LineTextField!
	@IBOutlet private weak var emailTextField: LineTextField!
	@IBOutlet private weak var phoneTextField: LineTextField!
	@IBOutlet private weak var passwordTextField: LineTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		
		nameTextField.setDelegate(self)
		emailTextField.setDelegate(self)
		phoneTextField.setDelegate(self)
		passwordTextField.setDelegate(self)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		nameTextField.activateTextField()
	}

}

extension SignInViewController: SignInView {
	
}

extension SignInViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		switch textField.tag {
		case 100:
			emailTextField.activateTextField()
			return false
		case 101:
			phoneTextField.activateTextField()
			return false
		case 102:
			passwordTextField.activateTextField()
			return false
		default:
			return true
		}
	}
}

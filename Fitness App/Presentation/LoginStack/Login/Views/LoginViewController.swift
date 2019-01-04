//
//  LoginViewController.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	var presenter: LoginPresenter<LoginViewController>!
	
	@IBOutlet private weak var emailTextField: LineTextField!
	@IBOutlet private weak var passwordTextField: LineTextField!
	@IBOutlet private weak var resetPasswordButton: UIButton!
	
	lazy var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		emailTextField.setDelegate(self)
		passwordTextField.setDelegate(self)
	}
	
	@IBAction func loginTapped(_ sender: UIButton) {
		let email = emailTextField.text == .wrongEmailConstant ? nil : emailTextField.text
		let password = passwordTextField.text == .wrongPasswordConstant ? nil : passwordTextField.text
		
		presenter.loginUser(withEmail: email,
							password: password)
	}
	
}

extension LoginViewController: LoginView {
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}
	
	func presentTutorialScreen() {
		print("presenting tutorial")
	}
	
	func showError() {
		passwordTextField.setErrorState(errorTitle: .wrongPasswordConstant)
		emailTextField.setErrorState(errorTitle: .wrongEmailConstant)
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = .center
		
		let resetAttributedString = NSAttributedString(string: .forgotPasswordConstant, attributes: [
			.foregroundColor: UIColor.grayNormalColor,
			.font: UIFont.systemFont(ofSize: 12),
			.paragraphStyle: paragraph
			])
		
		resetPasswordButton.isEnabled = true
		UIView.performWithoutAnimation {
			self.resetPasswordButton.setAttributedTitle(resetAttributedString, for: .normal)
			self.resetPasswordButton.layoutIfNeeded()
		}
	}
	
	
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		switch textField.text {
		case String.wrongPasswordConstant:
			passwordTextField.setNormalState(isSecure: true)
		case String.wrongEmailConstant:
			emailTextField.setNormalState()
		default:
			break
		}
	}
}

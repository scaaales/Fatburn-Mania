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
	
	private var textFieldAssistang: TextFieldAssistant!
	
	var shouldShowKeyboard = true
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		setupTextFields()
	}
	
	fileprivate func setupTextFields() {
		textFieldAssistang = .init(view: view, firstResponderTag: 100, lastResponderTag: 101)
		
		emailTextField.setDelegate(self)
		passwordTextField.setDelegate(self)
		
		let textViewHelperView = textFieldAssistang.textViewHelperView
		
		emailTextField.setInputAccessoryView(textViewHelperView)
		passwordTextField.setInputAccessoryView(textViewHelperView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if shouldShowKeyboard {
			emailTextField.activateTextField()
		}
	}
	
	@IBAction func login(_ sender: Any) {
		emailTextField.setNormalState()
		passwordTextField.setNormalState(isSecure: true)
		presenter.loginUser()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == String.presentTutorialSegueIdentifier,
			let tutorialViewController = segue.destination as? TutorialViewController {
			tutorialViewController.parrentController = self
		}
	}
	
}

extension LoginViewController: LoginView {
	var email: String {
		return emailTextField.text ?? ""
	}
	
	var password: String {
		return passwordTextField.text ?? ""
	}
	
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
		view.endEditing(true)
		performSegue(withIdentifier: .presentTutorialSegueIdentifier, sender: nil)
	}
	
	func showWrongPassword() {
		emailTextField.setErrorState(errorTitle: nil)
		emailTextField.clearOnNextEditing(false)
		
		passwordTextField.setErrorState(errorTitle: nil, isSecure: true)
		passwordTextField.clearOnNextEditing(true)
		
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
	
	func showErrors(_ errors: [LoginError]) {
		if errors.contains(.invalidEmail) {
			emailTextField.setErrorState(errorTitle: .wrongEmailConstant)
			emailTextField.clearOnNextEditing(true)
		}
		if errors.contains(.invalidPassword) {
			passwordTextField.setErrorState(errorTitle: .wrongPasswordConstant)
			passwordTextField.clearOnNextEditing(true)
		}
	}
	
	func showErrorPopup(with text: String) {
		let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
		alertController.addAction(.init(title: "Ok", style: .cancel))
		
		present(alertController, animated: true)
	}
	
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textFieldAssistang.currentResponderTag = textField.tag
		if emailTextField.isEqual(textField) {
			emailTextField.setNormalState()
		} else {
			passwordTextField.setNormalState(isSecure: true)
		}
		textField.clearsOnBeginEditing = false
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		if textField.tag == 100 {
			let nextResponderTag = textField.tag + 1
			textFieldAssistang.currentResponderTag = nextResponderTag
			return false
		} else {
			login(textField)
			return true
		}
	}
	
}

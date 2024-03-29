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
	
	private var textFieldAssistant: TextFieldAssistant!
	
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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		nameTextField.activateTextField()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		view.endEditing(true)
	}
	
	private func setupTextFields() {
		textFieldAssistant = .init(view: view, firstResponderTag: 100, lastResponderTag: 103)
		
		nameTextField.setDelegate(self)
		emailTextField.setDelegate(self)
		phoneTextField.setDelegate(self)
		passwordTextField.setDelegate(self)
	}
	
	@IBAction private func signInTapped() {
		presenter.signIn()
	}

}

extension SignInViewController: SignInView {
	var name: String { return nameTextField.text ?? "" }
	var email: String { return emailTextField.text ?? "" }
	var phone: String { return phoneTextField.text ?? ""}
	var password: String { return passwordTextField.text ?? "" }
	
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
	
	func showErrors(_ errors: [SignInError]) {
		if errors.contains(.invalidName) {
			nameTextField.setErrorState(errorTitle: "Invalid name")
			nameTextField.clearOnNextEditing(true)
		}
		if errors.contains(.invalidEmail) {
			emailTextField.setErrorState(errorTitle: "Invalid email")
			emailTextField.clearOnNextEditing(true)
		}
		if errors.contains(.invalidPhone) {
			phoneTextField.setErrorState(errorTitle: "Invalid phone")
			phoneTextField.clearOnNextEditing(true)
		}
		if errors.contains(.invalidPassword) {
			passwordTextField.setErrorState(errorTitle: "Invalid password")
			passwordTextField.clearOnNextEditing(true)
		}
	}
	
	func showSuccess(title: String, completion: @escaping () -> Void) {
		let alertController = UIAlertController(title: nil, message: title, preferredStyle: .alert)
		
		present(alertController, animated: true)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
			alertController.dismiss(animated: true, completion: completion)
		})
	}
	
	func pop() {
		navigationController?.popViewController(animated: true)
	}
}

extension SignInViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textFieldAssistant.currentResponderTag = textField.tag
		if nameTextField.isEqual(textField) {
			nameTextField.setNormalState()
		} else if emailTextField.isEqual(textField) {
			emailTextField.setNormalState()
		} else if phoneTextField.isEqual(textField) {
			phoneTextField.setNormalState()
		} else {
			passwordTextField.setNormalState(isSecure: true)
		}
		textField.clearsOnBeginEditing = false
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		if textField.tag == 100 {
			let nextResponderTag = textField.tag + 1
			textFieldAssistant.currentResponderTag = nextResponderTag
			return false
		} else {
			presenter.signIn()
			return true
		}
	}
	
}

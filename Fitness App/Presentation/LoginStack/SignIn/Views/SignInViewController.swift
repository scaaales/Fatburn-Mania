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
	
	private var textFieldAssistang: TextFieldAssistant!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hideKeyboardWhenTappedAround()
		setupTextFields()
	}
	
	private func setupTextFields() {
		textFieldAssistang = .init(view: view, firstResponderTag: 100, lastResponderTag: 103)
		
		nameTextField.setDelegate(textFieldAssistang)
		emailTextField.setDelegate(textFieldAssistang)
		phoneTextField.setDelegate(textFieldAssistang)
		passwordTextField.setDelegate(textFieldAssistang)
	
		let textViewHelperView = textFieldAssistang.textViewHelperView
		
		nameTextField.setInputAccessoryView(textViewHelperView)
		emailTextField.setInputAccessoryView(textViewHelperView)
		phoneTextField.setInputAccessoryView(textViewHelperView)
		passwordTextField.setInputAccessoryView(textViewHelperView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		nameTextField.activateTextField()
	}

}

extension SignInViewController: SignInView {
	
}


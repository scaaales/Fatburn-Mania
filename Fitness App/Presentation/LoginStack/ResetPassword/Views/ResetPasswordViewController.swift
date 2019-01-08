//
//  ResetPasswordViewController.swift
//  Fitness App
//
//  Created by scales on 1/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
	var presenter: ResetPasswordPresenter<ResetPasswordViewController>!
	
	@IBOutlet private weak var emailTextField: LineTextField!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var sendButton: RoundButton!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		emailTextField.setDelegate(self)
		hideKeyboardWhenTappedAround()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		emailTextField.activateTextField()
	}
	
	@IBAction func sendButtonTapped(_ sender: Any) {
		if sendButton.title(for: .normal) == String.closeConstant {
			navigationController?.popViewController(animated: true)
		} else {
			presenter.resetPassword(email: emailTextField.text)
		}
	}
	
}

extension ResetPasswordViewController: ResetPasswordView {
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
	
	func showSuccessSend() {
		emailTextField.removeFromSuperview()
		descriptionLabel.text = .emailWasSentConstant
		descriptionLabel.font = .systemFont(ofSize: 17)
		descriptionLabel.textColor = .black
		UIView.performWithoutAnimation {
			self.sendButton.setTitle(.closeConstant, for: .normal)
			self.sendButton.layoutIfNeeded()
		}
	}
	
	func showError() {
		print("error")
	}
	
	
}

extension ResetPasswordViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		presenter.resetPassword(email: emailTextField.text)
		return true
	}
}

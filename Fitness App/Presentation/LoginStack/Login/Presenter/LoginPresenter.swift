//
//  LoginPresenter.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

enum LoginError: Error {
	case invalidEmail
	case invalidPassword
}

class LoginPresenter<V: LoginView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func loginUser() {
		if let errors = getValidationErrors() {
			view.showErrors(errors)
		} else {
			view.disableUserInteraction()
			view.showLoader()
			FitnessApi.Auth.login(email: view.email, password: view.password, onComplete: {
				self.view.enableUserInteraction()
				self.view.hideLoader()
			}, onSuccess: { token, expiresIn in
				let keychain = KeychainSwift()
				let tokenExpirationDate = Date().addingTimeInterval(Double(expiresIn))
				
				keychain.set(token, forKey: .keychainKeyAccessToken)
				print(tokenExpirationDate)
				UserDefaults.standard.set(tokenExpirationDate, forKey: .userDefaultsKeyAccessTokenExpirationDate)
				
				self.view.presentTutorialScreen()
			}) { errorText in
				self.view.showWrongPassword()
				self.view.showErrorPopup(with: errorText)
			}
		}
	}
	
	private func isFieldsValid(email: String?, password: String?) -> Bool {
		if let email = email, let password = password {
			return !email.isEmpty && !password.isEmpty
		} else {
			return false
		}
	}
	
	func getValidationErrors() -> [LoginError]? {
		var errors = [LoginError]()
		if !view.email.isValidEmail() {
			errors.append(.invalidEmail)
		}
		if view.password.count < 6 {
			errors.append(.invalidPassword)
		}
		if errors.isEmpty {
			return nil
		} else {
			return errors
		}
	}
}

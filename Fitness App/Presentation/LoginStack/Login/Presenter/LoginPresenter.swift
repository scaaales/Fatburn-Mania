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
	private let authAPI = FitnessApi.Auth()
	
	required init(view: View) {
		self.view = view
	}
	
	func loginUser() {
		if view.email.isEmpty && view.password.isEmpty { #warning("just for testing, remove later")
			view.showTutorialScreen()
			return
		}
		if let errors = getValidationErrors() {
			view.showErrors(errors)
		} else {
			view.disableUserInteraction()
			view.showLoader()
			authAPI.login(email: view.email, password: view.password, onComplete: { [weak self] in
				self?.view.enableUserInteraction()
				self?.view.hideLoader()
			}, onSuccess: { [weak self] token, expiresIn in
				let keychain = KeychainSwift()
				let tokenExpirationDate = Date().addingTimeInterval(Double(expiresIn))
				
				keychain.set(token, forKey: .keychainKeyAccessToken)
				UserDefaults.standard.set(tokenExpirationDate, forKey: .userDefaultsKeyAccessTokenExpirationDate)
				
				self?.view.showTutorialScreen()
			}) { [weak self] errorText in
				self?.view.showWrongPassword()
				self?.view.showErrorPopup(with: errorText)
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

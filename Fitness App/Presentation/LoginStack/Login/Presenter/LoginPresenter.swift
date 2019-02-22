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
	private var notificationsAPI: FitnessApi.Notifications!
	
	required init(view: View) {
		self.view = view
	}
	
	func loginUser() {
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
				self?.sendDeviceToken(with: token)
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
	
	private func getValidationErrors() -> [LoginError]? {
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
	
	// APNS
	private func sendDeviceToken(with accessToken: String) {
		guard let deviceToken = AppDelegate.shared.pushNotificationService?.deviceToken else {
			view.showTutorialScreen()
			return
		}
		notificationsAPI = .init(token: accessToken)
		
		view.disableUserInteraction()
		view.showLoader()
		
		notificationsAPI.registerNotifications(deviceToken: deviceToken, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] in
			self?.view.showTutorialScreen()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
}

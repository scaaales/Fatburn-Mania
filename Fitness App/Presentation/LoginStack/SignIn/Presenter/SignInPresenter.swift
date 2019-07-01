//
//  SignInPresenter.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

enum SignInError: Error {
	case invalidName
	case invalidEmail
	case invalidPhone
	case invalidPassword
}

class SignInPresenter<V: SignInView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private let authAPI = FitnessApi.Auth()
	
	required init(view: View) {
		self.view = view
	}
	
	func signIn() {
		if let errors = getValidationErrors() {
			view.showErrors(errors)
		} else {
			view.disableUserInteraction()
			view.showLoader()
			authAPI.registerUserWith(name: view.name, phone: view.phone, email: view.email, password: view.password, onComplete: { [weak self] in
				self?.view.enableUserInteraction()
				self?.view.hideLoader()
			}, onSuccess: { [weak self] successText in
				self?.view.showSuccess(title: successText) {
					self?.view.pop()
				}
			}) { [weak self] errorText in
				self?.view.showErrorPopup(with: errorText)
			}
		}
	}
	
	private func getValidationErrors() -> [SignInError]? {
		var errors = [SignInError]()
		if view.name.isEmpty || view.name.count > 255 {
			errors.append(.invalidName)
		}
		if !view.email.isValidEmail() {
			errors.append(.invalidEmail)
		}
		if view.phone.isEmpty {
			errors.append(.invalidPhone)
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

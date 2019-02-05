//
//  SignInPresenter.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum SignInError: Error {
	case invalidName
	case invalidEmail
	case invalidPhone
	case invalidPassword
}

class SignInPresenter<V: SignInView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func signIn() {
		view.disableUserInteraction()
		if let errors = getValidationErrors() {
			view.enableUserInteraction()
			view.showErrors(errors)
		} else {
			view.showLoader()
			let provider = MoyaProvider<AuthService>()
			provider.request(.register(name: view.name,
									   phone: view.phone,
									   email: view.email,
									   password: view.password)) { [weak self] result in
										self?.view.enableUserInteraction()
										self?.view.hideLoader()
										
										switch result {
										case let .success(moyaResponse):
											if let jsonAny = try? moyaResponse.mapJSON(),
												let json = jsonAny as? [String: Any] {
												self?.handleJSON(json)
											}
										case let .failure(error):
											self?.view.showPopup(with: error.localizedDescription)
										}
			}
		}
	}
	
	private func getValidationErrors() -> [SignInError]? {
		var errors = [SignInError]()
		if view.name.isEmpty {
			errors.append(.invalidName)
		}
		if view.email.isEmpty {
			errors.append(.invalidEmail)
		}
		if view.phone.isEmpty {
			errors.append(.invalidPhone)
		}
		if view.password.isEmpty {
			errors.append(.invalidPassword)
		}
		if errors.isEmpty {
			return nil
		} else {
			return errors
		}
	}
	
	private func handleJSON(_ json: [String: Any]) {
		if let success = json["success"] as? Bool {
			if success {
				if let successText = json["message"] as? String {
					view.showSuccess(title: successText) { [weak self] in
						self?.view.pop()
					}
				}
			} else {
				if let error = json["error"] as? [String: [String]],
					let errorMessages = error["email"] {
					view.showPopup(with: errorMessages[0])
				}
			}
		}
	}
	
}

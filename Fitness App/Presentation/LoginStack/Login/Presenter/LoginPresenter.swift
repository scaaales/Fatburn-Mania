//
//  LoginPresenter.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class LoginPresenter<V: LoginView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func loginUser(withEmail email: String?, password: String?) {
		guard isFieldsValid(email: email, password: password) else {
			view.showError()
			return
		}
		view.disableUserInteraction()
		view.showLoader()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			self.view.hideLoader()
			if email == "q" && password == "q" {
				UserDefaults.standard.set(true, forKey: .userDefaultsKeyIsTutorialShown)
				self.view.presentTutorialScreen()
			} else {
				self.view.enableUserInteraction()
				self.view.showError()
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
}

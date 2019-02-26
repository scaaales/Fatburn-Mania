//
//  ResetPasswordPresenter.swift
//  Fitness App
//
//  Created by scales on 1/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ResetPasswordPresenter<V: ResetPasswordView>: Presenter { 
	typealias View = V
	
	weak var view: View!
	private var authApi: FitnessApi.Auth!
	
	required init(view: View) {
		self.view = view
	}
	
	func resetPassword(email: String?) {
		if let email = email, email.isValidEmail() {
			view.disableUserInteraction()
			view.showLoader()
			authApi = .init()
			
			authApi.resetPassword(email: email, onComplete: { [weak self] in
				self?.view.enableUserInteraction()
				self?.view.hideLoader()
			}, onSuccess: { [weak self] in
				self?.view.showSuccessSend()
			}) { [weak self] errorText in
				self?.view.showErrorPopup(with: errorText)
			}
		} else {
			view.showError()
		}
	}
}

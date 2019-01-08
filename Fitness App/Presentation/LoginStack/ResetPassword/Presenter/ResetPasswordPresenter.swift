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
	
	required init(view: View) {
		self.view = view
	}
	
	func resetPassword(email: String?) {
		view.disableUserInteraction()
		view.showLoader()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			self.view.hideLoader()
			self.view.enableUserInteraction()
			if email != nil && email != "" {
				self.view.showSuccessSend()
			} else {
				self.view.showError()
			}
		}
	}
}

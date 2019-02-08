//
//  LoadingSplashPresenter.swift
//  Fitness App
//
//  Created by scales on 2/7/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class LoadingSplashPresenter<V: LoadingSplashView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func decideRouting() {
		let keychain = KeychainSwift()
		if let token = keychain.get(.keychainKeyAccessToken) {
			if isTokenValid(token) {
				view.showMainScreen()
			} else {
				logout(with: token)
			}
		} else {
			view.showLoginScreen()
		}
	}
	
	private func isTokenValid(_ token: String) -> Bool {
		if let expireDate = UserDefaults.standard.value(forKey: .userDefaultsKeyAccessTokenExpirationDate) as? Date {
			let calendar = Calendar.current
			
			guard let dayBeforeExpire = calendar.date(byAdding: .day, value: -1, to: expireDate),
				let beginingOfTheDayBeforeExpire = calendar.dateInterval(of: .day, for: dayBeforeExpire)?.start else {
					return false
			}
			return beginingOfTheDayBeforeExpire > Date()
		} else {
			return false
		}
	}
	
	private func logout(with token: String) {
		view.showLoader()
		FitnessApi.Auth.logout(token: token,
							   onComplete: {
								self.view.hideLoader()
								let errorText = "Login session has expired. Please login again."
								self.view.showErrorPopup(with: errorText, okHandler: { [weak self] in
									self?.view.showLoginScreen()
								})
		}) { errorText in
			self.view.showErrorPopup(with: errorText, okHandler: { [weak self] in
				self?.view.showLoginScreen()
			})
		}
	}
	
	private func updateToken(_ oldToken: String) {
		view.showLoader()
	}
}

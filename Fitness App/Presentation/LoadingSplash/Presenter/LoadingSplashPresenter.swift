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
	private lazy var authAPI: FitnessApi.Auth = {
		return .init()
	}()
	
	required init(view: View) {
		self.view = view
	}
	
	func decideRouting() {
		let keychain = KeychainSwift()
		if let token = keychain.get(.keychainKeyAccessToken) {
			let tokenState = isTokenValid(token)
			if let isTokenValid = tokenState {
				if isTokenValid {
					view.showMainScreen()
				} else {
					keychain.delete(.keychainKeyAccessToken)
					UserDefaults.standard.removeObject(forKey: .userDefaultsKeyAccessTokenExpirationDate)
					logout(with: token)
				}
			} else {
				view.showLoginScreen()
			}
		} else {
			view.showLoginScreen()
		}
	}
	
	private func isTokenValid(_ token: String) -> Bool? {
		if let expireDate = UserDefaults.standard.value(forKey: .userDefaultsKeyAccessTokenExpirationDate) as? Date {
			let calendar = Calendar.current
			
			guard let dayBeforeExpire = calendar.date(byAdding: .day, value: -1, to: expireDate),
				let beginingOfTheDayBeforeExpire = calendar.dateInterval(of: .day, for: dayBeforeExpire)?.start else {
					return false
			}
			return beginingOfTheDayBeforeExpire > Date()
		} else {
			return nil
		}
	}
	
	private func logout(with token: String) {
		view.showLoader()
		authAPI.logout(token: token,
							   onComplete: { [weak self] in
								self?.view.hideLoader()
		}, onSuccess: { [weak self] in
			let errorText = "Login session has expired. Please login again."
			self?.view.showErrorPopup(with: errorText, okHandler: {
				self?.view.showLoginScreen()
			})
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText, okHandler: {
				self?.view.showLoginScreen()
			})
		}
	}
	
}

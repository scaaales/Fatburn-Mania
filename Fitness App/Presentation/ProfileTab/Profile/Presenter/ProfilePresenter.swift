//
//  ProfilePresenter.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class ProfilePresenter<V: ProfileView>: Presenter, UserCoinsUpdateDelegate {
	typealias View = V
	
	weak var view: View!
	private var viewModel: ProfileTableViewModel!
	private lazy var authAPI: FitnessApi.Auth = {
		return .init()
	}()
	private let profileAPI: FitnessApi.Profile
	private var notificationsAPI: FitnessApi.Notifications!
	
	private(set) var user: User!
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		profileAPI = .init(token: token)
	}
	
	func getUser() {
		view.disableUserInteraction()
		view.showLoader()
		view.hideTryAgainButton()
		
		profileAPI.getUserInfo(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] user in
			guard let self = self else { return }
			self.user = user
			self.viewModel = .init(user: user)
			self.viewModel.delegate = self
			self.view.setTableViewDataSource(self.viewModel)
			self.view.update()
			self.updateSteps()
		}) { [weak self] errorText in
			self?.view.showTryAgainButton()
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func logout() {
		if let deviceToken = AppDelegate.shared.pushNotificationService?.deviceToken {
			removeNotificationsToken(accessToken: profileAPI.token, deviceToken: deviceToken)
		} else {
			sendLogoutRequest()
		}
	}
	
	private func updateSteps() {
		HealthKitService.authorizeHealthKit { [weak self] (authorized, error) in
			if !authorized {
				let baseMessage = "HealthKit Authorization Failed"
				if let error = error {
					print("\(baseMessage). Reason: \(error.localizedDescription)")
				} else {
					print(baseMessage)
				}
			} else {
				self?.makeUpdateStepsRequest()
			}
		}
	}
	
	private func makeUpdateStepsRequest() {
		HealthKitService.getSteps(on: .init()) { [weak self] steps in
			guard let steps = steps else { return }
			self?.view.disableUserInteraction()
			self?.view.showLoader()
			
			self?.profileAPI.updateSteps(steps.current, onComplete: {
				self?.view.enableUserInteraction()
				self?.view.hideLoader()
			}, onSuccess: { [weak self] coinsAmount in
				if let coinsAmount = coinsAmount {
					NotificationCenter.default.post(name: .coinsAdded,
													object: self,
													userInfo: ["value": coinsAmount])
					self?.view.showCoinsAddedScreen(with: coinsAmount)
				}
			}, onError: { [weak self] errorText in
				self?.view.showErrorPopup(with: errorText)
			})
		}
	}
	
	private func sendLogoutRequest() {
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else { return }
		
		view.disableUserInteraction()
		view.showLoader()
		
		authAPI.logout(token: token, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] in
			keychain.delete(.keychainKeyAccessToken)
			UserDefaults.standard.removeObject(forKey: .userDefaultsKeyAccessTokenExpirationDate)
			self?.view.showLoginScreen()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	private func removeNotificationsToken(accessToken: String, deviceToken: String) {
		notificationsAPI = .init(token: accessToken)
		
		view.disableUserInteraction()
		view.showLoader()
		
		notificationsAPI.removeNotifictionsToken(deviceToken: deviceToken, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] in
			self?.sendLogoutRequest()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func getCellTitleFor(indexPath: IndexPath) -> String? {
		return viewModel.getCellTitleFor(at: indexPath.row)
	}
	
	func updateUser(with newUser: User) {
		self.user = newUser
		viewModel = .init(user: user)
		view.setTableViewDataSource(viewModel)
		view.update()
	}
	
	func userCoinsDidUpdate(coinsRow: Int) {
		view.reloadCellsWitoutAnimation(at: coinsRow)
	}

}



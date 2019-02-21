//
//  ProfilePresenter.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class ProfilePresenter<V: ProfileView>: Presenter { 
	typealias View = V
	
	weak var view: View!
	private var viewModel: ProfileTableViewModel!
	private let authAPI = FitnessApi.Auth()
	private let profileAPI: FitnessApi.Profile
	
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
		
		profileAPI.getUserInfo(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] user in
			guard let self = self else { return }
			self.user = user
			self.viewModel = .init(user: user)
			self.view.setTableViewDataSource(self.viewModel)
			self.view.update()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func logout() {
		view.disableUserInteraction()
		view.showLoader()
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else { return }
		
		authAPI.logout(token: token,
							   onComplete: { [weak self] in
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
	
	func getCellTitleFor(indexPath: IndexPath) -> String? {
		return viewModel.getCellTitleFor(at: indexPath.row)
	}
	
	func updateUser(with newUser: User) {
		print("got new user with \(newUser.fullName), \(newUser.lastName).")
		self.user = newUser
		viewModel = .init(user: user)
		view.setTableViewDataSource(viewModel)
		view.update()
	}

}



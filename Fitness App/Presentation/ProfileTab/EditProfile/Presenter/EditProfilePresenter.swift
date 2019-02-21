//
//  EditProfilePresenter.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class EditProfilePresenter<V: EditProfileView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: EditProfileTableViewModel!
	private let profileAPI: FitnessApi.Profile
	private var oldEmail: String!
	
	var user: User! {
		didSet {
			oldEmail = user.email ?? ""
		}
	}
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		profileAPI = .init(token: token)
	}
	
	func getUser() {
		viewModel = .init(user: user,
						  textFieldDelegate: view.textFieldDelegate,
						  datePickerView: view.viewForDateInput,
						  helperView: view.helperView)
		view.setTableViewDataSource(viewModel)
		view.update()
	}
	
	func saveChanges() {
		var newUser = viewModel.user
	
		if newUser.email == oldEmail {
			 newUser.email = nil
		}
		
		newUser.avatar = nil

		uploadNewUserInfo(newUser)
//		if let avatar = avatar {
//			uploadImage(avatar)
//		}
	}
	
	private func uploadNewUserInfo(_ user: User) {
		view.disableUserInteraction()
		view.showLoader()
		
		profileAPI.updateUser(user, onComplete: { [weak self] in
			print("updateUser completed")
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] user in
			self?.user = user
			self?.view.closeItself()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	private func uploadImage(_ image: UIImage) {
		guard let avatarData = image.pngData() else { return }
		profileAPI.updateAvatar(avatarData, onComplete: {
			print("updateAvatar completed")
		}, onSuccess: {
			
		}) { errorText in
			print(errorText)
		}
	}
	
	func getBirthdayDate() -> Date {
		return user.dateOfBirth ?? .init()
	}
}

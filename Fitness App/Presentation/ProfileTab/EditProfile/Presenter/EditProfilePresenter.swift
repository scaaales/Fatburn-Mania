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
	
	var user: User!
	
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
//		let avatar = view.avatar
//		let firstName = view.firstName
//		let lastName = view.lastName ?? ""
//		let nickname = view.nickname ?? ""
//		let gender = view.gender
//		let dateOfBirth = view.dateOfBirth
//		let email = view.email
//		let phone = view.phone
//		let instagram = view.instagram ?? ""
//		let country = view.country ?? ""
//		let city = view.city ?? ""
//
//		let emailToSend: String?
//
//		if email == user.email {
//			emailToSend = nil
//		} else {
//			emailToSend = email
//		}
//
//		let newUser = User(firstName: firstName, lastName: lastName,
//						   nickname: nickname, gender: gender,
//						   dateOfBirth: dateOfBirth, email: emailToSend,
//						   phone: phone, instagram: instagram,
//						   country: country, city: city)
//		uploadNewUserInfo(newUser)
//		if let avatar = avatar {
//			uploadImage(avatar)
//		}
	}
	
	private func uploadNewUserInfo(_ user: User) {
		profileAPI.updateUser(user, onComplete: {
			print("updateUser completed")
		}, onSuccess: {
			
		}) { errorText in
			print(errorText)
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

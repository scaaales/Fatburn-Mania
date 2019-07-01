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
	private var photoLibraryService: PhotoLibraryService!
	private var avatarPhoto: UIImage?
	private var requestsDispatchGroup: DispatchGroup?
	private var successCompletionsDispatchGroup: DispatchGroup?
	
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
		
		requestsDispatchGroup = .init()
		successCompletionsDispatchGroup = .init()
		
		if let avatar = avatarPhoto,
			let resizedImage = avatar.resized(toMaxSide: 300) {
			successCompletionsDispatchGroup?.enter()
			requestsDispatchGroup?.enter()
			uploadImage(resizedImage)
		}
		
		successCompletionsDispatchGroup?.enter()
		requestsDispatchGroup?.enter()
		uploadNewUserInfo(newUser)
		
		successCompletionsDispatchGroup?.notify(queue: .main, execute: { [weak self] in
			self?.view.closeItself()
		})
		
		requestsDispatchGroup?.notify(queue: .main, execute: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		})
	}
	
	private func uploadNewUserInfo(_ user: User) {
		view.disableUserInteraction()
		view.showLoader()
		
		profileAPI.updateUser(user, onComplete: { [weak self] in
			self?.requestsDispatchGroup?.leave()
		}, onSuccess: { [weak self] user in
			self?.user = user
			self?.successCompletionsDispatchGroup?.leave()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	private func uploadImage(_ image: UIImage) {
		guard let avatarData = image.jpegData(compressionQuality: 80) else { return }
		profileAPI.updateAvatar(avatarData, onComplete: { [weak self] in
			self?.requestsDispatchGroup?.leave()
		}, onSuccess: { [weak self] user in
			self?.user = user
			self?.successCompletionsDispatchGroup?.leave()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func getBirthdayDate() -> Date {
		return user.dateOfBirth ?? .init()
	}
	
	func addPhoto() {
		photoLibraryService = PhotoLibraryService(viewControllerToPresentPicker: view.viewControllerToPresentPicker)
		authorizeIfNeeded { [weak self] in
			self?.photoLibraryService.getImage { image in
				if let image = image {
					self?.avatarPhoto = image
					self?.view.setPhoto(image)
				}
			}
		}
	}
	
	private func authorizeIfNeeded(successCompletion: @escaping () -> Void) {
		if photoLibraryService.authorized {
			successCompletion()
		} else {
			photoLibraryService.authorize { success in
				if success {
					successCompletion()
				}
			}
		}
	}
}

//
//  CourseVideosPresenter.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class CourseVideosPresenter<V: CourseVideosView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: CourseVideosTableViewModel!
	private let profileAPI: FitnessApi.Profile
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		profileAPI = .init(token: token)
	}
	
	func getVideos() {
		view.disableUserInteraction()
		view.showLoader()
		
		profileAPI.getVideos(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] videos in
			guard let self = self else { return }
			self.viewModel = .init(videos: videos)
			self.view.setTableViewDataSource(self.viewModel.dataSource)
			self.view.update()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func getVideoDetailsForVideo(at row: Int) {
		guard let video = viewModel.getVideoAtIndex(row) else { return }
		view.showVideoDetails(video)
	}
}

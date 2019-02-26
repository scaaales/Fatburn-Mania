//
//  WorkoutOfTheDayPresenter.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class WorkoutOfTheDayPresenter<V: WorkoutOfTheDayView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: LessonsTableViewModel!
	private let workoutsApi: FitnessApi.Workouts
	private(set) var exercises: [Exercise]!
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		workoutsApi = .init(token: token)
	}
	
	func getWorkoutOfTheDay() {
		view.disableUserInteraction()
		view.hideAllViews()
		view.showLoader()
		
		workoutsApi.getWorkoutOfTheDay(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] workoutOfTheDay in
			guard let self = self else { return }
			self.exercises = workoutOfTheDay.exercises
			self.viewModel = .init(exercises: self.exercises)
			self.view.setTableViewDataSource(self.viewModel.dataSource)
			self.view.setLessonName(workoutOfTheDay.title,
									reward: workoutOfTheDay.reward,
									duration: workoutOfTheDay.duration,
									description: workoutOfTheDay.text)
			self.view.setPreviewImage(from: workoutOfTheDay.photo)
			self.view.setLessonSponsorImage(#imageLiteral(resourceName: "fatburnManiaLogo")); #warning("temp")
			self.view.update()
			self.view.showAllViews()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func getVideoUrl(at index: Int) -> URL? {
		guard !exercises[index].isBreak,
			let videoUrlString = exercises[index].video,
			let fixedVideoUrlString = videoUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
		
		return URL(string: fixedVideoUrlString)
	}
}

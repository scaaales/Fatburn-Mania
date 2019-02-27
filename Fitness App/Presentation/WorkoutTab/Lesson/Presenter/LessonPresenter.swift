//
//  LessonPresenter.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class LessonPresenter<V: LessonView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var lesson: Lesson!
	private let workoutsApi: FitnessApi.Workouts
	private var viewModel: LessonsTableViewModel!
	private(set) var exercises: [Exercise]!
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		workoutsApi = .init(token: token)
	}
	
	func setLesson(_ lesson: Lesson) {
		self.lesson = lesson
	}
	
	func getLesson() {
		view.setTitle(lesson.title,
					  lessonName: lesson.title,
					  description: lesson.text,
					  digitOfTheDay: "Digit of the day: " + lesson.digit)
		
		if let videoUrlString = lesson.video,
			let fixedUrlString = videoUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
			view.setVideo(from: fixedUrlString)
		} else if let photoUrlString = lesson.photo {
			view.setPhoto(from: photoUrlString)
		}
		
		if lesson.isNews {
			view.setupForNewsState()
		} else {
			view.hideAllViews()
			view.disableUserInteraction()
			view.showLoader()
			
			workoutsApi.getExerciseFor(workoutId: lesson.id, onComplete: { [weak self] in
				self?.view.enableUserInteraction()
				self?.view.hideLoader()
				}, onSuccess: { [weak self] exercises in
					guard let self = self else { return }
					self.exercises = exercises
					self.viewModel = .init(exercises: exercises)
					self.view.setTableViewDataSource(self.viewModel.dataSource)
					self.view.update()
					self.view.showAllViews()
			}) { [weak self] errorText in
				self?.view.showErrorPopup(with: errorText)
			}
		}
	}
	
	func getVideoUrl(at index: Int) -> URL? {
		guard !exercises[index].isBreak,
			let videoUrlString = exercises[index].video,
			let fixedVideoUrlString = videoUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
		
		return URL(string: fixedVideoUrlString)
	}
	
	func uploadPhoto(_ photo: UIImage) {
		guard let fixedResizedPhoto = photo.fixOrientation()?.resized(toMaxSide: 1000),
			let photoData = fixedResizedPhoto.jpegData(compressionQuality: 80) else { return }
		
		view.disableUserInteraction()
		view.showLoader()
		
		workoutsApi.uploadPhoto(photoData, workoutId: lesson.id, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] in
			self?.view.showPopup(with: nil, text: "Your photo was uploaded successfully!")
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
}

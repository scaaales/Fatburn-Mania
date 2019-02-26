//
//  WorkoutPresenter.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class WorkoutPresenter<V: WorkoutView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: WorkoutTableViewModel!
	private let workoutsApi: FitnessApi.Workouts
	private var lessons = [Lesson]()
	private(set) var seasons: [Season]!
	
	var selectedSeasonID: Int! {
		didSet {
			loadSelectedSeason()
		}
	}
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		workoutsApi = .init(token: token)
	}
	
	func getCurrentSeason() {
		view.disableUserInteraction()
		view.showLoader()
		view.hideSegments()
		view.hideTableView()
		view.hideTryAgainButton()
		view.disableSeasonsButton()
		
		workoutsApi.getSeasons(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] seasons in
			self?.seasons = seasons
			self?.view.enableSeasonsButton()
			self?.selectedSeasonID = seasons.last?.id
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
			self?.view.showTryAgainButton()
		}
	}
	
	private func loadSelectedSeason() {
		view.disableUserInteraction()
		view.showLoader()
		view.hideSegments()
		view.hideTableView()
		view.hideTryAgainButton()
		view.disableSeasonsButton()
		
		workoutsApi.getWorkoutsFor(seasonId: selectedSeasonID, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] lessons in
			self?.view.enableSeasonsButton()
			self?.handleLessons(lessons)
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
			self?.view.showTryAgainButton()
		}
		
	}
	
	private func handleLessons(_ lessons: [Lesson]) {
		self.lessons = lessons
		
		let weeks = lessons.map { $0.week }.unique.sorted().map { "\($0)" }
		view.setSegments(titles: weeks)
		
		getLessonsForWeek(at: 0)
	}
	
	func getLessonsForWeek(at index: Int) {
		let currentWeekLessons = lessons.filter{ $0.week == index }
		if let viewModel = self.viewModel {
			viewModel.replaceLessons(with: currentWeekLessons)
		} else {
			viewModel = .init(lessons: currentWeekLessons)
			view.setTableViewDataSource(viewModel.dataSource)
		}
		
		view.showSegments()
		view.showTableView()
		view.update()
	}
	
	func getLessonAt(index: Int) -> Lesson {
		return viewModel.getLessonAtIndex(index)
	}
	
}

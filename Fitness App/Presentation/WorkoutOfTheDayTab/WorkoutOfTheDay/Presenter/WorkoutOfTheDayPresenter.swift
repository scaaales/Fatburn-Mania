//
//  WorkoutOfTheDayPresenter.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutOfTheDayPresenter<V: WorkoutOfTheDayView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: LessonsTableViewModel!
	
	required init(view: View) {
		self.view = view
	}
	
	func getWorkoutOfTheDay() {
		// api call to get workout of the day
		let exercises = Exercise.testExercises
		let workoutOfTheDay = WorkoutOfTheDay(name: "Сахарная вата",
											  duration: 16,
											  rewardCoins: 7,
											  desritpion: .loremIpsumConstant,
											  previewImage: #imageLiteral(resourceName: "workoutImage"),
											  sponsorImage: #imageLiteral(resourceName: "fatburnManiaLogo"),
											  exercises: exercises)
		
		viewModel = .init(exercises: exercises)
		
		view.setTableViewDataSource(viewModel.dataSource)
		view.setLessonName(workoutOfTheDay.name,
						   reward: workoutOfTheDay.rewardCoins,
						   duration: workoutOfTheDay.duration,
						   description: workoutOfTheDay.desritpion)
	}
}

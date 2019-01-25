//
//  ExercisePresenter.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ExercisePresenter<V: ExerciseView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var isPaused = false
	private var workoutOfTheDay: WorkoutOfTheDay!
	private var exercises: [Exercise] {
		return workoutOfTheDay.exercises
	}
	
	private var currentExerciseIndex: Int!
	
	required init(view: View) {
		self.view = view
	}
	
	func getInitialExercise() {
		let exercises = Exercise.testExercises
		workoutOfTheDay = .init(name: "Сахарная вата",
								duration: 960,
								rewardCoins: 7,
								desritpion: .loremIpsumConstant,
								previewImage: #imageLiteral(resourceName: "workoutImage"),
								sponsorImage: #imageLiteral(resourceName: "fatburnManiaLogo"),
								exercises: exercises)
		currentExerciseIndex = 0
		loadCurrentExercise()
		view.setVideo()
	}
	
	func togglePaused() {
		isPaused.toggle()
		if isPaused {
			view.setupForPausedState()
		} else {
			view.setupForPlayingState()
		}
	}
	
	func getNextExercise() {
		currentExerciseIndex += 1
		loadCurrentExercise()
	}
	
	private func loadCurrentExercise() {
		let currentExercise = exercises[currentExerciseIndex]
		
		view.setExerciseName(currentExercise.name)
		view.setTotalTime(.init(workoutOfTheDay.duration))
		view.setCurrentTime(0)
		view.setExerciseTime(currentExercise.duration)
		view.setPercentageProgress(0)
		
		let nextExercise = exercises[safe: currentExerciseIndex + 1]
		view.setNextExerciseName(nextExercise?.name)
	}
}

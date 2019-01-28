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
	private var timer: Timer!
	
	private var currentExerciseIndex: Int!
	private var currentExerciseTimePassed: TimeInterval = 0
	private var totalTimePassed: TimeInterval = 0
	
	required init(view: View) {
		self.view = view
	}
	
	func getInitialExercise() {
		let exercises = Exercise.testExercises
		workoutOfTheDay = .init(name: "Сахарная вата",
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
		if isPaused { return }
		let currentExerciseTimeRemaining = exercises[currentExerciseIndex].duration - currentExerciseTimePassed
		totalTimePassed += currentExerciseTimeRemaining
		timer.invalidate()
		currentExerciseTimePassed = 0
		currentExerciseIndex += 1
		loadCurrentExercise()
	}
	
	private func loadCurrentExercise() {
		if totalTimePassed == workoutOfTheDay.duration {
			print("workout complete")
			return
		}
		timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] _ in
			guard let self = self, !self.isPaused else { return }
			self.workoutSecondPasses()
		})
		
		RunLoop.current.add(timer, forMode: .common)
		
		let currentExercise = exercises[currentExerciseIndex]
		
		view.setExerciseName(currentExercise.name)
		view.setTotalTime(workoutOfTheDay.duration)
		view.setCurrentTime(totalTimePassed)
		let percentage = Float(totalTimePassed/workoutOfTheDay.duration)
		view.setPercentageProgress(percentage)
		view.setExerciseTime(currentExercise.duration)
		
		let nextExercise = exercises[safe: currentExerciseIndex + 1]
		view.setNextExerciseName(nextExercise?.name)
	}
	
	private func workoutSecondPasses() {
		let currentExercise = exercises[currentExerciseIndex]
		currentExerciseTimePassed += 1
		
		if currentExercise.duration < currentExerciseTimePassed {
			currentExerciseTimePassed -= 1
			getNextExercise()
			return
		}
		
		totalTimePassed += 1
		
		view.setCurrentTime(totalTimePassed)
		let percentage = Float(totalTimePassed/workoutOfTheDay.duration)
		view.setPercentageProgress(percentage)
		
		view.setExerciseTime(currentExercise.duration - currentExerciseTimePassed)
	}
	
	deinit {
		timer.invalidate()
	}
}

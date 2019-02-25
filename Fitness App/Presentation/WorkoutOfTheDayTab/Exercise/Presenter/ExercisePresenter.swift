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
	private var workoutOfTheDay: WorkoutOfTheDay!
	private var exercises: [Exercise] {
		return workoutOfTheDay.exercises
	}
	private var timer: Timer!
	
	private var currentExerciseIndex: Int!
	private var currentExerciseTimePassed: TimeInterval = 0
	private var totalTimePassed: TimeInterval = 0
	private var currentCountdown: TimeInterval = 3 {
		didSet {
			view.setCountdownTime(currentCountdown)
		}
	}
	
	required init(view: View) {
		self.view = view
	}
	
	func getInitialExercise() {
//		let exercises = Exercise.testExercises
//		workoutOfTheDay = .init(name: "Сахарная вата",
//								rewardCoins: 7,
//								desritpion: .loremIpsumConstant,
//								previewImage: #imageLiteral(resourceName: "workoutImage"),
//								sponsorImage: #imageLiteral(resourceName: "fatburnManiaLogo"),
//								exercises: exercises)
//		setupTimer()
//		currentExerciseIndex = 0
//		view.state = .initialCountdown
	}
	
	private func setupTimer() {
		timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] _ in
			guard let self = self else { return }
			switch self.view.state {
			case .initialCountdown, .nextExerciseCountdown:
				self.countdownSecondPassed()
			case .playing:
				self.workoutSecondPassed()
			case .paused:
				break
			}
		})
		
		RunLoop.current.add(timer, forMode: .common)
	}
	
	func togglePaused() {
		switch view.state {
		case .playing:
			view.state = .paused
		case .paused:
			view.state = .playing
		default:
			print("weard state \(view.state)")
		}
	}
	
	func getNextExercise() {
		if view.state != .playing { return }
		let currentExerciseTimeRemaining = exercises[currentExerciseIndex].duration - currentExerciseTimePassed
		totalTimePassed += currentExerciseTimeRemaining
		currentExerciseTimePassed = 0
		currentExerciseIndex += 1
		
		timer.invalidate()
		setupTimer()
		
		currentCountdown = 3
		view.state = .nextExerciseCountdown
		guard let nextExercise = exercises[safe: currentExerciseIndex] else { return }
		if nextExercise.isBreak {
			view.setBreakPicture()
		} else {
			view.setVideo()
		}
	}
	
	private func loadCurrentExercise() {
		if totalTimePassed == workoutOfTheDay.duration {
			print("workout complete")
			return
		}
		
		let currentExercise = exercises[currentExerciseIndex]
		
		if currentExercise.isBreak {
			view.setBreakPicture()
		} else {
			view.setVideo()
		}
		
		view.setExerciseName(currentExercise.title)
		view.setTotalTime(workoutOfTheDay.duration)
		view.setCurrentTime(totalTimePassed)
		let percentage = Float(totalTimePassed/workoutOfTheDay.duration)
		view.setPercentageProgress(percentage)
		view.setExerciseTime(currentExercise.duration)
		
		let nextExercise = exercises[safe: currentExerciseIndex + 1]
		view.setNextExerciseName(nextExercise?.title)
	}
	
	private func workoutSecondPassed() {
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
	
	private func countdownSecondPassed() {
		currentCountdown -= 1
		if currentCountdown < 0 {
			view.state = .playing
			loadCurrentExercise()
		}
	}
	
	deinit {
		timer.invalidate()
	}
}

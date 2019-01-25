//
//  ExerciseView.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol ExerciseView: View {
	func setupForPausedState()
	func setupForPlayingState()
	func setCurrentTime(_ currentTime: TimeInterval)
	func setTotalTime(_ totalTime: TimeInterval)
	func setPercentageProgress(_ percentage: Float)
	func setExerciseTime(_ exerciseTime: TimeInterval)
	func setExerciseName(_ exerciseName: String)
	func setNextExerciseName(_ nextExerciseName: String?)
	func setVideo()
}

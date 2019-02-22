//
//  WorkoutTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutTableViewModel {
	
	let dataSource: BasicTableViewDataSource<WorkoutCell, Workout>
	
	init(workouts: [Workout]) {
		dataSource = .init(items: workouts)
	}
	
	func replaceWorkouts(with newWorkouts: [Workout]) {
		dataSource.replaceItems(with: newWorkouts)
	}
	
	func getWorkoutAtIndex(_ index: Int) -> Workout {
		return dataSource.getItemAtIndex(index)
	}
}

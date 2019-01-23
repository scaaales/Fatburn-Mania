//
//  WorkoutTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutTableViewModel {
	
	let dataSource: BasicTableViewDataSource<WorkoutCell, Lesson>
	
	init(lessons: [Lesson]) {
		dataSource = .init(items: lessons)
	}
	
	func replaceLessons(with newLessons: [Lesson]) {
		dataSource.replaceItems(with: newLessons)
	}
}

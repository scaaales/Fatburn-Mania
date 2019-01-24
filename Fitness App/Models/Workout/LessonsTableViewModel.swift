//
//  LessonsTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class LessonsTableViewModel {
	
	let dataSource: BasicTableViewDataSource<ExerciseCell, Exercise>!
	
	init(exercises: [Exercise]) {
		dataSource = .init(items: exercises)
	}
	
}

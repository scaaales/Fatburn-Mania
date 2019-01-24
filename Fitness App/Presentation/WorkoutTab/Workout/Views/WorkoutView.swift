//
//  WorkoutView.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol WorkoutView: View, TableViewUpdatable {
	func setSegments(titles: [String])
}


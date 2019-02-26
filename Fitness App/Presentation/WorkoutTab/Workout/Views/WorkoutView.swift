//
//  WorkoutView.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol WorkoutView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	func setSegments(titles: [String])
	func hideSegments()
	func showSegments()
	
	func hideTableView()
	func showTableView()
	
	func disableSeasonsButton()
	func enableSeasonsButton()
	
	func showTryAgainButton()
	func hideTryAgainButton()
}


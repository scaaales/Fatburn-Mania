//
//  WorkoutPresenter.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutPresenter<V: WorkoutView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
}

//
//  WorkoutViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
	var presenter: WorkoutPresenter<WorkoutViewController>!
	
	@IBOutlet private weak var workoutSeasonsSegments: CustomSegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		workoutSeasonsSegments.setItemsTitles(["0", "1", "2", "3", "4", "5", "6"])
		// Do any additional setup after loading the view.
	}
	
}

extension WorkoutViewController: WorkoutView {
	
}


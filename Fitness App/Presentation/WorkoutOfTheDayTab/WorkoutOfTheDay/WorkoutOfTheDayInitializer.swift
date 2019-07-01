//
//  WorkoutOfTheDayInitializer.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutOfTheDayInitializer: NSObject {
	@IBOutlet weak var viewController: WorkoutOfTheDayViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


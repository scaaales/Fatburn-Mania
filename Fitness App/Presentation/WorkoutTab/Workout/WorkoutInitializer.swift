//
//  WorkoutInitializer.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutInitializer: NSObject {
	@IBOutlet weak var viewController: WorkoutViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


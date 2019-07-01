//
//  ExerciseInitializer.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ExerciseInitializer: NSObject {
	@IBOutlet weak var viewController: ExerciseViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


//
//  AddNewMeasurementsInitializer.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class AddNewMeasurementsInitializer: NSObject {
	@IBOutlet weak var viewController: AddNewMeasurementsViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


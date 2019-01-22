//
//  MeasureHistoryInitializer.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class MeasureHistoryInitializer: NSObject {
	@IBOutlet weak var viewController: MeasureHistoryViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


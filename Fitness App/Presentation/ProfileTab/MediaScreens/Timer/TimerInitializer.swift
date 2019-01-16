//
//  TimerInitializer.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class TimerInitializer: NSObject {
	@IBOutlet weak var viewController: TimerViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


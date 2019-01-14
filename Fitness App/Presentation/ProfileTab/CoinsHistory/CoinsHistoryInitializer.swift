//
//  CoinsHistoryInitializer.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class CoinsHistoryInitializer: NSObject {
	@IBOutlet weak var viewController: CoinsHistoryViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


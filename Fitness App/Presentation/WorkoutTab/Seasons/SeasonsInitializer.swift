//
//  SeasonsInitializer.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class SeasonsInitializer: NSObject {
	@IBOutlet weak var viewController: SeasonsViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


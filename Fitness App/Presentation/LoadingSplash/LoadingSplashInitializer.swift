//
//  LoadingSplashInitializer.swift
//  Fitness App
//
//  Created by scales on 2/7/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class LoadingSplashInitializer: NSObject {
	@IBOutlet weak var viewController: LoadingSplashViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


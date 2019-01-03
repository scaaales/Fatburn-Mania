//
//  LoginSplashInitializer.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class LoginSplashInitializer: NSObject {
	@IBOutlet weak var viewController: LoginSplashViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}

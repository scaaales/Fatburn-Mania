//
//  ResetPassrodInitializer.swift
//  Fitness App
//
//  Created by scales on 1/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ResetPassrodInitializer: NSObject {
	@IBOutlet weak var viewController: ResetPasswordViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


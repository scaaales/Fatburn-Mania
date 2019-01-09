//
//  ProfileInitializer.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ProfileInitializer: NSObject {
	@IBOutlet weak var viewController: ProfileViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


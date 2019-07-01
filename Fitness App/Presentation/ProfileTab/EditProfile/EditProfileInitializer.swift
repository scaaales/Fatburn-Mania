//
//  EditProfileInitializer.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class EditProfileInitializer: NSObject {
	@IBOutlet weak var viewController: EditProfileViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


//
//  NotificationsInitializer.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class NotificationsInitializer: NSObject {
	@IBOutlet weak var viewController: NotificationsViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


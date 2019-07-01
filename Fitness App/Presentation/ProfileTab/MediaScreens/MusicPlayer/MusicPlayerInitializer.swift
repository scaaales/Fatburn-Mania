//
//  MusicPlayerInitializer.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class MusicPlayerInitializer: NSObject {
	@IBOutlet weak var viewController: MusicPlayerViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


//
//  VideoDetailsInitializer.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class VideoDetailsInitializer: NSObject {
	@IBOutlet weak var viewController: VideoDetailsViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


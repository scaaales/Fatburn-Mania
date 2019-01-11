//
//  VideoLibraryInitializer.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class VideoLibraryInitializer: NSObject {
	@IBOutlet weak var viewController: VideoLibraryViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


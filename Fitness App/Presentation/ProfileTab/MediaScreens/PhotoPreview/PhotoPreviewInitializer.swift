//
//  PhotoPreviewInitializer.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class PhotoPreviewInitializer: NSObject {
	@IBOutlet weak var viewController: PhotoPreviewViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


//
//  CourseVideosInitializer.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class CourseVideosInitializer: NSObject {
	@IBOutlet weak var viewController: CourseVideosViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}


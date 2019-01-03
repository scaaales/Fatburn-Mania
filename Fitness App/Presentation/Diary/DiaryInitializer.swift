//
//  DiaryInitializer.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class DiaryInitializer: NSObject {
	@IBOutlet weak var viewController: DiaryViewController!
	
	override func awakeFromNib() {
		let configurator = Configurator(view: viewController)
		configurator.configurate()
	}
}

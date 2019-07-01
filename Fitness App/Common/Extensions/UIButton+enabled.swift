//
//  UIButton+enabled.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIButton {
	func setEnabled(_ enabled: Bool) {
		isEnabled = enabled
		if enabled {
			alpha = 1
		} else {
			alpha = 0.5
		}
	}
}

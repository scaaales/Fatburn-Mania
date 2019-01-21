//
//  TimeInterval+extension.swift
//  Fitness App
//
//  Created by scales on 1/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

extension TimeInterval {
	
	var stringFromTimeInterval: String {
		let time = NSInteger(self)

		let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
		let seconds = time % 60
		let minutes = (time / 60) % 60
		
		return String(format: "%0.2d:%0.2d:%0.2d", minutes, seconds, ms)
	}
}

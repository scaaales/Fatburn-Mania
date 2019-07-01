//
//  UIColor+extension.swift
//  Fitness App
//
//  Created by scales on 1/4/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIColor {
	convenience init(with hex:String) {
		var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}
		
		if ((cString.count) != 6) {
			self.init()
			return
		}
		
		var rgbValue: UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		self.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}

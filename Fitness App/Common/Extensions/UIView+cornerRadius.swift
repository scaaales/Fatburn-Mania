//
//  UIView+cornerRadius.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIView {
	func makeCornerRadius(_ radius: CGFloat) {
		layer.cornerRadius = radius
		layer.masksToBounds = true
	}
}

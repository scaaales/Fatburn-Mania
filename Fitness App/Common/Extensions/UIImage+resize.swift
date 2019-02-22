//
//  UIImage+resized.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIImage {
	func resized(toMaxSide side: CGFloat) -> UIImage? {
		let canvasSize: CGSize
		if size.width > size.height {
			canvasSize = .init(width: side, height: CGFloat(ceil(side/size.width * size.height)))
		} else {
			canvasSize = .init(width: CGFloat(ceil(size.width * side/size.height)), height: side)
		}
		UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
		defer { UIGraphicsEndImageContext() }
		draw(in: CGRect(origin: .zero, size: canvasSize))
		return UIGraphicsGetImageFromCurrentImageContext()
	}

}

//
//  UIImageView+rotate.swift
//  Fitness App
//
//  Created by scales on 1/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIImageView {
	
	func rotateImageToAngle(angle: CGFloat) {
		guard let oldCGImage = image?.cgImage else { return }
		
		var orientation: UIImage.Orientation
		switch angle {
		case (CGFloat.pi / 2), (-3 * CGFloat.pi / 2):
			orientation = .right
		case (-CGFloat.pi / 2), (3 * CGFloat.pi / 2):
			orientation = .left
		case CGFloat.pi, -CGFloat.pi:
			orientation = .down
		case 0:
			orientation = .up
		default:
			return
		}
		let newImage = UIImage(cgImage: oldCGImage, scale: 1, orientation: orientation)
		image = newImage
	}
}

//
//  ImageCreator.swift
//  Fitness App
//
//  Created by scales on 1/17/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ImageCreator {
	static func createImage(with size: CGSize, from view: UIView, offsetY: CGFloat) -> UIImage {
		UIGraphicsBeginImageContext(size)
		
		CGContext.translateBy(UIGraphicsGetCurrentContext()!)(x: 0, y: -offsetY)
		
		view.layer.render(in: UIGraphicsGetCurrentContext()!)
		guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError() }
		
		return image
	}
}

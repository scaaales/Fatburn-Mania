//
//  UIImage+fixOrientation.swift
//  Fitness App
//
//  Created by scales on 2/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIImage {
	
	func fixOrientation() -> UIImage? {
		
		if (imageOrientation == .up) { return self }
		
		var transform = CGAffineTransform.identity
		
		switch imageOrientation {
		case .left, .leftMirrored:
			transform = transform.translatedBy(x: size.width, y: 0.0)
			transform = transform.rotated(by: .pi / 2.0)
		case .right, .rightMirrored:
			transform = transform.translatedBy(x: 0.0, y: size.height)
			transform = transform.rotated(by: -.pi / 2.0)
		case .down, .downMirrored:
			transform = transform.translatedBy(x: size.width, y: size.height)
			transform = transform.rotated(by: .pi)
		default:
			break
		}
		
		switch imageOrientation {
		case .upMirrored, .downMirrored:
			transform = transform.translatedBy(x: size.width, y: 0.0)
			transform = transform.scaledBy(x: -1.0, y: 1.0)
		case .leftMirrored, .rightMirrored:
			transform = transform.translatedBy(x: size.height, y: 0.0)
			transform = transform.scaledBy(x: -1.0, y: 1.0)
		default:
			break
		}
		
		guard let cgImg = cgImage else { return nil }
		
		if let context = CGContext(data: nil,
								   width: Int(size.width), height: Int(size.height),
								   bitsPerComponent: cgImg.bitsPerComponent,
								   bytesPerRow: 0, space: cgImg.colorSpace!,
								   bitmapInfo: cgImg.bitmapInfo.rawValue) {
			
			context.concatenate(transform)
			
			if imageOrientation == .left || imageOrientation == .leftMirrored ||
				imageOrientation == .right || imageOrientation == .rightMirrored {
				context.draw(cgImg, in: CGRect(x: 0.0, y: 0.0, width: size.height, height: size.width))
			} else {
				context.draw(cgImg, in: CGRect(x: 0.0 , y: 0.0, width: size.width, height: size.height))
			}
			
			if let contextImage = context.makeImage() {
				return UIImage(cgImage: contextImage)
			}
			
		}
		
		return nil
	}
	
}

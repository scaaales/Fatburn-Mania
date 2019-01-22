//
//  CenteredThumbSlider.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CenteredThumbSlider: UISlider {
	override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect
	{
		let unadjustedThumbrect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
		let thumbOffsetToApplyOnEachSide = unadjustedThumbrect.size.width / 2.0
		let minOffsetToAdd = -thumbOffsetToApplyOnEachSide
		let maxOffsetToAdd = thumbOffsetToApplyOnEachSide
		let offsetForValue = minOffsetToAdd + (maxOffsetToAdd - minOffsetToAdd) * CGFloat(value / (self.maximumValue - self.minimumValue))
		var origin = unadjustedThumbrect.origin
		origin.x += offsetForValue
		origin.y += 2
		return CGRect(origin: origin, size: unadjustedThumbrect.size)
	}
}

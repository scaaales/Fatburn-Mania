//
//  PhotoLevelView.swift
//  Fitness App
//
//  Created by scales on 2/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class PhotoLevelView: UIView {
	private lazy var presenter: PhotoLevelPresenter = {
		return PhotoLevelPresenter(view: self)
	}()
	
	@IBOutlet private weak var rotatingCenterView: UIView!
	@IBOutlet private weak var staticCenterCircleView: UIView!
	
	@IBOutlet private var movingViews: [UIView]!
	@IBOutlet private weak var movingViewsOffsetPositionConstraint: NSLayoutConstraint!
	
	func startUpdate() {
		presenter.startUpdate()
	}
	
	func stopUpdate() {
		presenter.stopUpdate()
	}
	
	func setRotation(value: Double) {
		var color: UIColor
		if value == 0 {
			color = .green
		} else {
			color = .grayNormalColor
		}
		
		UIView.animate(withDuration: presenter.updateInterval) {
			self.rotatingCenterView.transform = CGAffineTransform(rotationAngle: CGFloat(value))
			self.rotatingCenterView.backgroundColor = color
			self.staticCenterCircleView.backgroundColor = color
		}
	}
	
	func setMovingViewsOffset(value: Double) {
		var color: UIColor
		if value == 0 {
			color = .green
		} else {
			color = .normalBlueColor
		}
		
		let newOffset = (self.frame.height - 65) / 2 * CGFloat(value)
		movingViewsOffsetPositionConstraint.constant = CGFloat(newOffset)
		
		UIView.animate(withDuration: presenter.updateInterval) {
			self.layoutIfNeeded()
			self.movingViews.forEach { $0.backgroundColor = color }
		}
	}
	
}

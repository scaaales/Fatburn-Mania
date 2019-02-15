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
	@IBOutlet private weak var movingViewsOffsetPositionConstraint: NSLayoutConstraint!
	
	func startUpdate() {
		presenter.startUpdate()
	}
	
	func stopUpdate() {
		presenter.stopUpdate()
	}
	
	func setRotation(value: Double) {
		rotatingCenterView.transform = CGAffineTransform(rotationAngle: CGFloat(value))
	}
	
	func setMovingViewsOffset(value: Double) {
		let newOffset = (self.frame.height / 2 * CGFloat(value)) - 32.5
		movingViewsOffsetPositionConstraint.constant = CGFloat(newOffset)
	}
	
}

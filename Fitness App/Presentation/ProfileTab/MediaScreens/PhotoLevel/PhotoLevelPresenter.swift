//
//  PhotoLevelPresenter.swift
//  Fitness App
//
//  Created by scales on 2/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import CoreMotion
import simd

class PhotoLevelPresenter {
	weak var view: PhotoLevelView!
	
	private let motionManager: CMMotionManager
	
	init(view: PhotoLevelView) {
		self.view = view
		motionManager = .init()
	}
	
	func startUpdate() {
		guard motionManager.isAccelerometerAvailable else { return }
		
		motionManager.accelerometerUpdateInterval = 0.1
		
		motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
			guard let accelerometerData = accelerometerData else { return }
			
			let x = accelerometerData.acceleration.x
			let z = accelerometerData.acceleration.z
			self.handleAcceleration(x: x, z: z)
		}
		
	}
	
	private func handleAcceleration(x: Double, z: Double) { // x angle left-right, z angle up-down
		let angle = 45 * Double(x)
		let radians = angle / 180.0 * Double.pi
		view.setRotation(value: radians)
		
		view.setMovingViewsOffset(value: -z)
	}
	
	func stopUpdate() {
		guard motionManager.isAccelerometerAvailable else { return }
		
		motionManager.stopAccelerometerUpdates()
	}
}

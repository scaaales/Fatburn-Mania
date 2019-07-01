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
	let updateInterval: Double = 0.2
	
	private let acceptableRadians = 0.05
	private let acceptableZ = 0.01
	
	init(view: PhotoLevelView) {
		self.view = view
		motionManager = .init()
	}
	
	func startUpdate() {
		guard motionManager.isAccelerometerAvailable else { return }
		
		motionManager.accelerometerUpdateInterval = updateInterval
		
		motionManager.startAccelerometerUpdates(to: .main) { [weak self] accelerometerData, error in
			guard let accelerometerData = accelerometerData else { return }
			
			let x = accelerometerData.acceleration.x
			let z = accelerometerData.acceleration.z
			self?.handleAcceleration(x: x, z: z)
		}
		
	}
	
	private func handleAcceleration(x: Double, z: Double) { // x angle left-right, z angle up-down
		let angle = 90 * x
		let radians = angle / 180.0 * Double.pi
		let roundedRadians = (radians * 100).rounded() / 100
		
		if abs(roundedRadians) <= acceptableRadians {
			view.setRotation(value: 0)
		} else {
			view.setRotation(value: roundedRadians)
		}
		
		let roundedZ = (z * 100).rounded() / 100
		if abs(roundedZ) <= acceptableZ {
			view.setMovingViewsOffset(value: 0)
		} else {
			view.setMovingViewsOffset(value: -roundedZ)
		}
		
	}
	
	func stopUpdate() {
		guard motionManager.isAccelerometerAvailable else { return }
		
		motionManager.stopAccelerometerUpdates()
	}
}

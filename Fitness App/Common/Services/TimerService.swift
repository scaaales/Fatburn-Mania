//
//  TimerService.swift
//  Fitness App
//
//  Created by scales on 1/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TimerService {

	private let totalStartDate: Date
	private var lapStartDate: Date
	private var totalPauseInterval: TimeInterval = 0
	private var lapPauseInterval: TimeInterval = 0
	
	private var pauseDate: Date?
	
	private let updateHandler: (_ timePassed: TimeInterval) -> Void
	private var lapHandler: ((_ timePassed: TimeInterval) -> Void)
	private var displayLink: CADisplayLink!
	
	init(updateHandler: @escaping (_ timePassed: TimeInterval) -> Void,
		 lapHandler: @escaping (_ timePassed: TimeInterval) -> Void) {
		totalStartDate = .init()
		self.updateHandler = updateHandler
		self.lapHandler = lapHandler
		self.lapStartDate = totalStartDate
		
		displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
		displayLink.add(to: .main, forMode: .common)
	}
	
	func startNewLap() {
		lapStartDate = .init()
		lapPauseInterval = 0
	}
	
	@objc private func handleUpdate() {
		let now = Date()
		let elapsedTime = now.timeIntervalSince(totalStartDate)
		let totalTimeWithoutPause = elapsedTime - totalPauseInterval
		updateHandler(totalTimeWithoutPause)
		let lapElapsedTime = now.timeIntervalSince(lapStartDate)
		let lapTimeWithoutPause = lapElapsedTime - lapPauseInterval
		lapHandler(lapTimeWithoutPause)
	}
	
	func pause() {
		pauseDate = .init()
		displayLink.isPaused = true
	}
	
	func resume() -> TimeInterval? {
		if let pauseDate = self.pauseDate {
			let lastPauseInterval = Date().timeIntervalSince(pauseDate)
			totalPauseInterval += lastPauseInterval
			lapPauseInterval += lastPauseInterval
			displayLink.isPaused = false
			return lastPauseInterval
		}
		return nil
	}
	
	func invalidate() {
		displayLink.invalidate()
	}
	
}

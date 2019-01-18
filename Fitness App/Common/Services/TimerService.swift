//
//  TimerService.swift
//  Fitness App
//
//  Created by scales on 1/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TimerService: NSObject {

	private let totalStartDate: Date
	private var lapStartDate: Date?
	
	private let updateHandler: (_ timePassed: TimeInterval) -> Void
	private var lapHandler: ((_ timePassed: TimeInterval) -> Void)?
	
	init(updateHandler: @escaping (_ timePassed: TimeInterval) -> Void) {
		totalStartDate = .init()
		self.updateHandler = updateHandler
		super.init()
		let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
		displayLink.add(to: .main, forMode: .common)
	}
	
	func startNewLap(lapHandler: @escaping (_ timePassed: TimeInterval) -> Void) {
		lapStartDate = .init()
		self.lapHandler = lapHandler
	}
	
	@objc private func handleUpdate() {
		let now = Date()
		let elapsedTime = now.timeIntervalSince(totalStartDate)
		updateHandler(elapsedTime)
		guard let lapStartDate = self.lapStartDate else { return }
		let lapElapsedTime = now.timeIntervalSince(lapStartDate)
		lapHandler?(lapElapsedTime)
	}
	
}

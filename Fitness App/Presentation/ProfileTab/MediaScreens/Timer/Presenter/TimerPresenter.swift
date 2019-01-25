//
//  TimerPresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class TimerPresenter<V: TimerView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var dataSource: BasicTableViewDataSource<TimerCell, TimerCell.DataType>!
	private var timer: TimerService!
	private var prevLapTimeString: String?
	private var numberOfLaps: Int = 0 {
		didSet {
			view.setLapNumber(numberOfLaps)
		}
	}
	
	required init(view: View) {
		self.view = view
	}
	
	func startTimer() {
		resetTimer()
		
		view.setRestButton(enabled: true)
		view.setLapButton(enabled: true)
		view.setStartButton(enabled: false)
		view.setContinueButton(enabled: false)
		view.setResetButton(enabled: true)
		
		timer = TimerService(updateHandler: { [weak self] timeInterval in
			self?.view.setTotalTime(timeInterval.stringFromTimeIntervalWithMilliseconds)
			}, lapHandler: { [weak self] timeInterval in
				self?.prevLapTimeString = timeInterval.stringFromTimeIntervalWithMilliseconds
				self?.view.setLapTime(timeInterval.stringFromTimeIntervalWithMilliseconds)
		})
	}
	
	func finishLap() {
		guard let lapTime = prevLapTimeString else { return }
		let item = (title: "Lap \(numberOfLaps)", time: lapTime)
		startNewLap()
		dataSource.addItem(item, at: 0)
		view.addRowAtTheTop()
	}
	
	func restTimer() {
		view.setRestButton(enabled: false)
		view.setLapButton(enabled: false)
		view.setStartButton(enabled: false)
		view.setContinueButton(enabled: true)
		view.setResetButton(enabled: true)
		
		timer.pause()
	}
	
	func continueTimer() {
		if let lastRestTimeInterval = timer.resume() {
			view.setRestButton(enabled: true)
			view.setLapButton(enabled: true)
			view.setStartButton(enabled: false)
			view.setContinueButton(enabled: false)
			view.setResetButton(enabled: true)
			
			let item = (title: "Rest", time: lastRestTimeInterval.stringFromTimeIntervalWithMilliseconds)
			dataSource.addItem(item, at: 0)
			view.addRowAtTheTop()
		}
	}
	
	func resetTimer() {
		view.setRestButton(enabled: false)
		view.setLapButton(enabled: false)
		view.setStartButton(enabled: true)
		view.setContinueButton(enabled: false)
		view.setResetButton(enabled: false)
		
		timer?.invalidate()
		timer = nil
		setupDataSource()
		numberOfLaps = 1
		view.setInitialViewState()
	}
	
	private func setupDataSource() {
		dataSource = .init(items: [])
		view.setTableViewDataSource(dataSource)
	}
	
	private func startNewLap() {
		timer.startNewLap()
		numberOfLaps += 1
	}
}

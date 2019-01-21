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
		timer = TimerService(updateHandler: { [weak self] timeInterval in
			self?.view.setTotalTime(timeInterval.stringFromTimeInterval)
			}, lapHandler: { [weak self] timeInterval in
				self?.prevLapTimeString = timeInterval.stringFromTimeInterval
				self?.view.setLapTime(timeInterval.stringFromTimeInterval)
		})
		startNewLap()
	}
	
	func finishLap() {
		guard let lapTime = prevLapTimeString else { return }
		let item = (title: "Lap \(numberOfLaps)", time: lapTime)
		startNewLap()
		dataSource.addItem(item, at: 0)
		view.addRowAtTheTop()
	}
	
	func restTimer() {
		timer.pause()
	}
	
	func continueTimer() {
		if let lastRestTimeInterval = timer.resume() {
			let item = (title: "Rest", time: lastRestTimeInterval.stringFromTimeInterval)
			dataSource.addItem(item, at: 0)
			view.addRowAtTheTop()
		}
		
	}
	
	func resetTimer() {
		timer?.invalidate()
		timer = nil
		setupDataSource()
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

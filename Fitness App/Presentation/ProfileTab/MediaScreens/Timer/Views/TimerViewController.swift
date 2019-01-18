//
//  TimerViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
	var presenter: TimerPresenter<TimerViewController>!
	
	@IBOutlet private weak var totalTimeLabel: UILabel!
	@IBOutlet private weak var lapNumberLabel: UILabel!
	@IBOutlet private weak var lapTimeLabel: UILabel!
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.backgroundColor = .clear
		tableView.delegate = self
	}
	
	@IBAction private func restTapped() {
		
	}
	
	@IBAction private func lapTapped() {
		presenter.finishLap()
	}
	
	@IBAction private func startTapped() {
		presenter.startTimer()
	}
	
	@IBAction private func continueTapped() {
		
	}
	
	@IBAction private func resetTapped() {
		
	}
	
}

extension TimerViewController: TimerView {
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
		tableView.reloadData()
	}
	
	func addRowAtTheTop() {
		tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
	}
	
	func setTotalTime(_ time: String) {
		totalTimeLabel.text = time
	}
	
	func setLapTime(_ time: String) {
		lapTimeLabel.text = time
	}
	
	func setLapNumber(_ number: Int) {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .ordinal
		let nsNumber = NSNumber(integerLiteral: number)
		guard let formattedNumber = numberFormatter.string(from: nsNumber) else { return }
		lapNumberLabel.text = "Lap time (\(formattedNumber) lap)"
	}
	
}

extension TimerViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}



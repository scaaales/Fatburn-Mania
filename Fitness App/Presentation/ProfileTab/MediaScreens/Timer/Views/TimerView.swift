//
//  TimerView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol TimerView: View {
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
	func addRowAtTheTop()
	func setTotalTime(_ time: String)
	func setLapTime(_ time: String)
	func setLapNumber(_ number: Int)
}

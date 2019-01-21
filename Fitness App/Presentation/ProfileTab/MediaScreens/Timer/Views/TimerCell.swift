//
//  TimerCell.swift
//  Fitness App
//
//  Created by scales on 1/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TimerCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = (title: String, time: String)
	
	@IBOutlet private weak var titleTextLabel: UILabel!
	@IBOutlet private weak var timeLabel: UILabel!
	
	func configure(data: DataType) {
		if data.title == "Rest" {
			titleTextLabel.textColor = .black
			timeLabel.textColor = .black
		} else {
			titleTextLabel.textColor = .darkBlueColor
			timeLabel.textColor = .darkBlueColor
		}
		titleTextLabel.text = data.title
		timeLabel.text = data.time
	}

}

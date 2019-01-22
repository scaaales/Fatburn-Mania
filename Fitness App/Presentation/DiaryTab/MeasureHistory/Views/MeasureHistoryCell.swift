//
//  MeasureHistoryCell.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MeasureHistoryCell: UITableViewCell, ConfigurableCell {
	typealias DataType = MeasureHistory
	
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var chestValueLabel: UILabel!
	@IBOutlet private weak var waistValueLabel: UILabel!
	@IBOutlet private weak var thigsValueLabel: UILabel!
	@IBOutlet private weak var hipValueLabel: UILabel!
	@IBOutlet private weak var waightValueLabel: UILabel!

	func configure(data: MeasureHistory) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy"
		
		dateLabel.text = dateFormatter.string(from: data.date).lowercased()
		chestValueLabel.text = "\(data.cheshMeasurement)"
		waistValueLabel.text = "\(data.waistMeasurement)"
		thigsValueLabel.text = "\(data.thigsMeasurement)"
		hipValueLabel.text = "\(data.hipMeasurement)"
		waightValueLabel.text = "\(data.waightMeasurement)"
	}
	
}

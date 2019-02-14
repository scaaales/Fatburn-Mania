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
	@IBOutlet private weak var thighsValueLabel: UILabel!
	@IBOutlet private weak var hipValueLabel: UILabel!
	@IBOutlet private weak var weightValueLabel: UILabel!

	func configure(data: MeasureHistory) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy"
		
		dateLabel.text = dateFormatter.string(from: data.date).lowercased()
		chestValueLabel.text = "\(data.measurements.chest)"
		waistValueLabel.text = "\(data.measurements.waist)"
		thighsValueLabel.text = "\(data.measurements.thighs)"
		hipValueLabel.text = "\(data.measurements.hip)"
		weightValueLabel.text = "\(data.measurements.weight)"
	}
	
}

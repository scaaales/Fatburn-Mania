//
//  MeasureHistoryCell.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MeasureHistoryCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Measurements
	
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var chestValueLabel: UILabel!
	@IBOutlet private weak var waistValueLabel: UILabel!
	@IBOutlet private weak var thighsValueLabel: UILabel!
	@IBOutlet private weak var hipValueLabel: UILabel!
	@IBOutlet private weak var weightValueLabel: UILabel!

	func configure(data: Measurements) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
		
		if let date = data.date {
			dateLabel.text = dateFormatter.string(from: date).lowercased()
		} else {
			dateLabel.text = "Unknown date"
		}
		chestValueLabel.text = "\(data.chest)"
		waistValueLabel.text = "\(data.waist)"
		thighsValueLabel.text = "\(data.thighs)"
		hipValueLabel.text = "\(data.hip)"
		weightValueLabel.text = String(format: "%g", data.weight)
	}
	
}

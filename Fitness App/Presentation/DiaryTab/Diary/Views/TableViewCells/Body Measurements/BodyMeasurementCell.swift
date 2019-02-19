//
//  BodyMeasurementCell.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class BodyMeasurementCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Measurement
	
	@IBOutlet private weak var oldValueLabel: UILabel!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var newValueLabel: UILabel!
	
	func configure(data: Measurement) {
		if let oldValue = data.firstValue {
			oldValueLabel.text = "\(oldValue) \(data.unit)"
		} else {
			oldValueLabel.text = "--"
		}
		
		nameLabel.text = data.name
		
		if let newValue = data.secondValue {
			newValueLabel.text = "\(newValue) \(data.unit)"
		} else {
			newValueLabel.text = "--"
		}
	}
}

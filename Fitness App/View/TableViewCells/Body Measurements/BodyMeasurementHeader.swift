//
//  BodyMeasurementHeader.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class BodyMeasurementHeader: UITableViewCell, ConfigurableCell {
	typealias DataType = MeasurementPeriod
	
	@IBOutlet private weak var startDateLabel: UILabel!
	@IBOutlet private weak var endDateLabel: UILabel!
	
	func configure(data: MeasurementPeriod) {
		startDateLabel.text = data.startDate
		endDateLabel.text = data.endDate
	}
}

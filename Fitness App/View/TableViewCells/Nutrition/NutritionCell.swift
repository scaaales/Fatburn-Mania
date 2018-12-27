//
//  NutritionCell.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class NutritionCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Measurement
	
	@IBOutlet weak var progressView: ProgressView!
	
	func configure(data: Measurement) {
		guard let secondValue = data.secondValue else { return }
		let endValue = "\(data.firstValue)/\(secondValue) \(data.unit)"
		progressView.setProgress(startValue: data.name, endValue: endValue, progress: .random(in: 0...1))
		progressView.setBottomLabels(hidden: true)
	}
}

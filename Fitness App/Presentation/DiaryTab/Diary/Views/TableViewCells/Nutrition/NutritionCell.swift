//
//  NutritionCell.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class NutritionCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Measurement
	
	@IBOutlet weak var progressView: ProgressView!
	
	func configure(data: Measurement) {
		guard let firstValue = data.firstValue,
			let secondValue = data.secondValue,
			let progress = data.progress else { return }
		let endValue = "\(Int(firstValue))/\(Int(secondValue)) \(data.unit)"
			
		progressView.setProgress(startValue: data.name, endValue: endValue, progress: progress)
		progressView.setBottomLabels(hidden: true)
	}
}

//
//  WaterCell.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class WaterCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Measurement
	
	@IBOutlet private weak var progressView: ProgressView!
	
	func configure(data: Measurement) {
		guard let secondValue = data.secondValue,
			let progress = data.progress else { return }
		
		let startString = "\(data.firstValue)"
		let endString = "\(secondValue) \(data.unit)"
		
		progressView.setProgress(startValue: startString, endValue: endString, progress: progress)
		progressView.setBottomLabels(hidden: false)
	}
}

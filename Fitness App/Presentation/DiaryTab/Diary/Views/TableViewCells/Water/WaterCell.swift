//
//  WaterCell.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class WaterCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Measurement
	
	@IBOutlet private(set) weak var progressView: ProgressView!
	
	func configure(data: Measurement) {
		guard let firstValue = data.firstValue,
			let secondValue = data.secondValue,
			let progress = data.progress else { return }
		
		let firstValueRounded = (firstValue * 100).rounded() / 100
		let startString = String(format: "%g", firstValueRounded) + " \(data.unit)"
		let endString = "\(Int(secondValue)) \(data.unit)"
		
		progressView.setProgress(startValue: startString, endValue: endString, progress: progress)
		progressView.setBottomLabels(hidden: false)
	}
}

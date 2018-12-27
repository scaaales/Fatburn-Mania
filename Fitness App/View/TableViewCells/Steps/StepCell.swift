//
//  StepCell.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class StepCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Steps
	
	@IBOutlet private weak var progressView: ProgressView!
	
	func configure(data: Steps) {
		progressView.setProgress(startValue: "\(data.current)", endValue: "\(data.goal)", progress: Float(data.current)/Float(data.goal))
		progressView.setBottomLabels(hidden: false)
	}
}

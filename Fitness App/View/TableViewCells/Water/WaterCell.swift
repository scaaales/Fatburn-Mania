//
//  WaterCell.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class WaterCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Water
	
	@IBOutlet private weak var progressView: ProgressView!
	
	func configure(data: Water) {
		progressView.setProgress(startValue: data.result, endValue: data.result, progress: 1)
		progressView.setBottomLabels(hidden: false)
	}
}

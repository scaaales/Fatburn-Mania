//
//  CoinsHistoryHeader.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CoinsHistoryHeader: CellWithSeperator, ConfigurableCell {
	typealias DataType = String

	@IBOutlet private weak var dateLabel: UILabel!
	
	func configure(data: String) {
		dateLabel.text = data
	}
	
}

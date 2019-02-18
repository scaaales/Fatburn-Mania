//
//  CoinsHistoryCell.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CoinsHistoryCell: UITableViewCell, ConfigurableCell {
	typealias DataType = CoinsHistory

	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var numberLabel: UILabel!
	
	func configure(data: CoinsHistory) {
		nameLabel.text = data.type
		if data.numberOfCoins >= 0 {
			numberLabel.text = "+\(data.numberOfCoins)"
		} else {
			numberLabel.text = "\(data.numberOfCoins)"
		}
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM"
		let dateString = dateFormatter.string(from: data.date).lowercased()
		dateLabel.text = dateString
	}
}

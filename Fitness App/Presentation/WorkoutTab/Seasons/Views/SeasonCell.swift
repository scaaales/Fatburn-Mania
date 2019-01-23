//
//  SeasonCell.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class SeasonCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Season

	@IBOutlet private weak var seasonNameLabel: UILabel!
	@IBOutlet private weak var seasonImage: UIImageView!
	
	func configure(data: Season) {
		seasonImage.makeCornerRadius(15)
		seasonImage.image = data.image
		seasonNameLabel.text = data.title
	}

}

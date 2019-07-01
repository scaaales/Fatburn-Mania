//
//  UserButtonArrowCell.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class UserButtonArrowCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = (icon: UIImage, text: String)
	
	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	
	func configure(data: DataType) {
		icon.image = data.icon
		titleLabel.text = data.text
	}

}

//
//  BalanceCell.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class BalanceCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = UInt
	
	@IBOutlet private weak var coinsLabel: UILabel!
	
	func configure(data: UInt) {
		coinsLabel.text = "\(data)"
	}

}

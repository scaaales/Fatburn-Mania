//
//  HowToTextCell.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class HowToTextCell: UITableViewCell, ConfigurableCell {
	typealias DataType = String
	
	@IBOutlet private weak var tutorialText: UITextView!
	
	func configure(data: String) {
		tutorialText.text = data
	}

}

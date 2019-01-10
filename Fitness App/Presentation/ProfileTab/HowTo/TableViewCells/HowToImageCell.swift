//
//  HowToImageCell.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class HowToImageCell: UITableViewCell, ConfigurableCell {
	typealias DataType = UIImage
	
	@IBOutlet private weak var tutorialImage: UIImageView!
	
	func configure(data: UIImage) {
		tutorialImage.image = data
	}

}

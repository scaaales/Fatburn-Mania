//
//  TutorialCell.swift
//  Fitness App
//
//  Created by scales on 1/4/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell, ConfigurableCell {
	typealias DataType = UIImage
	
	@IBOutlet private weak var tutorialImageView: UIImageView!
	
	func configure(data: UIImage) {
		tutorialImageView.image = data
		tutorialImageView.makeCornerRadius(16)
	}
	
}

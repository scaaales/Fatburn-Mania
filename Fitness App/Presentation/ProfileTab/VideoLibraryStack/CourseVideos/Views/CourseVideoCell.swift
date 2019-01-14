//
//  CourseVideoCell.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CourseVideoCell: UITableViewCell, ConfigurableCell {
	typealias DataType = (image: UIImage, title: String, subtitle: String)
	
	@IBOutlet private weak var courseImageView: UIImageView!
	@IBOutlet private weak var courseTitleSubtitleLabel: UILabel!
	
	func configure(data: DataType) {
		courseImageView.image = data.image
		courseTitleSubtitleLabel.text = data.title + "\n" + data.subtitle
		courseImageView.makeCornerRadius(16)
	}

}

//
//  CourseVideoCell.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CourseVideoCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Video
	
	@IBOutlet private weak var courseImageView: UIImageView!
	@IBOutlet private weak var courseTitleSubtitleLabel: UILabel!
	
	func configure(data: Video) {
		courseImageView.setImageFrom(urlString: data.photo)
		courseTitleSubtitleLabel.text = data.title
		courseImageView.makeCornerRadius(16)
	}

}

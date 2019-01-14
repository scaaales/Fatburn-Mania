//
//  VideoLibraryCell.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class VideoLibraryCell: UICollectionViewCell, ConfigurableCell {
	typealias DataType = (image: UIImage, title: String)
	
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var title: UILabel!
	
	func configure(data: DataType) {
		imageView.image = data.image
		title.text = data.title
		imageView.makeCornerRadius(16)
	}
}

//
//  StoreItemCell.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Product
	
	@IBOutlet private weak var productImageView: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var priceLabel: UILabel!
	@IBOutlet private weak var readMoreButton: UIButton!
	
	func configure(data: Product) {
		productImageView.setImageFrom(urlString: data.photoUrlString)
		titleLabel.text = data.title
		descriptionLabel.text = data.shortDescription
		priceLabel.text = "\(data.price.formattedWithSeparator) c."
		productImageView.makeCornerRadius(16)
		readMoreButton.tag = data.id
	}

}

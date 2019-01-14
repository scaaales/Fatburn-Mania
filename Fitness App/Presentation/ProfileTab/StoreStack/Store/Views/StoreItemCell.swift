//
//  StoreItemCell.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell, ConfigurableCell {
	typealias DataType = (product: Product, row: Int)
	
	@IBOutlet private weak var productImageView: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var priceLabel: UILabel!
	@IBOutlet private weak var readMoreButton: UIButton!
	
	func configure(data: (product: Product, row: Int)) {
		let product = data.product
		productImageView.image = product.picture
		titleLabel.text = product.name
		descriptionLabel.text = product.description
		priceLabel.text = "\(product.price.formattedWithSeparator) c."
		productImageView.makeCornerRadius(16)
		readMoreButton.tag = data.row
	}

}

//
//  ProfileHeaderCell.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ProfileHeaderCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = (imageURLString: String?, name: String)
	
	@IBOutlet private weak var avatarImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	
	func configure(data: DataType) {
		if let imageUrlString = data.imageURLString {
			avatarImageView.setImageFrom(urlString: imageUrlString)
		} else {
			avatarImageView.image = #imageLiteral(resourceName: "user_test")
		}
		avatarImageView.makeCornerRadius(avatarImageView.bounds.height / 2)
		
		nameLabel.text = data.name
	}

}

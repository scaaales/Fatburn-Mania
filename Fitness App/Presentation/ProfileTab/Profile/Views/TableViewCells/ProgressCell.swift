//
//  ProgressCell.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ProgressCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = [UIImage]
	
	@IBOutlet private var images: [UIImageView]!
	
	func configure(data: [UIImage]) {
		data.enumerated().forEach { (arg0) in
			let (offset, image) = arg0
			images.first(where: { $0.tag == offset })?.image = image
		}
	}
}

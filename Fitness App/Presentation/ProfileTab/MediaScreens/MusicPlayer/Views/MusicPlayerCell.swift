//
//  MusicPlayerCell.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MusicPlayerCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = Song
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var artistLabel: UILabel!
	@IBOutlet private weak var durationLabel: UILabel!
	
	func configure(data: Song) {
		nameLabel.text = data.name
		artistLabel.text = data.artist
		durationLabel.text = data.duration
	}

}

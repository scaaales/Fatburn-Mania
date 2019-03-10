//
//  MusicPlayerCell.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MusicPlayerCell: CellWithSeperator, ConfigurableCell {
	typealias DataType = (song: Song, row: Int)
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var artistLabel: UILabel!
	@IBOutlet private weak var durationLabel: UILabel!
	@IBOutlet private weak var playPauseButton: UIButton!
	
	func configure(data: DataType) {
		nameLabel.text = data.song.title
		artistLabel.text = data.song.subtitle
		durationLabel.text = data.song.duration
		playPauseButton.tag = data.row
	}

}

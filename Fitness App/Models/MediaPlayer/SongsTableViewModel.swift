//
//  SongsTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class SongsTableViewModel {
	typealias DataType = MusicPlayerCell.DataType
	
	let dataSource: BasicTableViewDataSource<MusicPlayerCell, DataType>
	
	init(items: [Song]) {
		let resultItems = items.enumerated().map { (song: $1, row: $0) }
		dataSource = .init(items: resultItems)
	}
	
	func getSongAt(index: Int) -> Song? {
		return dataSource.getItemAtIndex(index)?.song
	}

}

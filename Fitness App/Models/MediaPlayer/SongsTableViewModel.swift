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
	
	init(items: [Song]? = nil) {
		var resultItems: [DataType]
		if let items = items {
			resultItems = items.enumerated().map { (song: $1, row: $0) }
		} else {
			resultItems = (0...20).map{ (song: Song(name: "VOL. \($0)", artist: "Radio", duration: "61:42", url: nil), row: $0) }
		}
		
		dataSource = .init(items: resultItems)
	}
	
	func getSongAt(index: Int) -> Song {
		return dataSource.getItemAtIndex(index).song
	}

}

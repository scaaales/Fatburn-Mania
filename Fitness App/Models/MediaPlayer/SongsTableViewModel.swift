//
//  SongsTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class SongsTableViewModel {
	let dataSource: BasicTableViewDataSource<MusicPlayerCell, Song>
	
	init(items: [Song]? = nil) {
		var resultItems: [Song]
		if let items = items {
			resultItems = items
		} else {
			resultItems = (0...20).map({ Song(name: "VOL. \($0)", artist: "Radio", duration: "61:42", url: nil) })
		}
		
		dataSource = .init(items: resultItems)
	}

}

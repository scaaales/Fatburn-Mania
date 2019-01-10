//
//  VideoLibraryCollectionViewModel.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class VideoLibraryCollectionViewModel {
	typealias DataType = (image: UIImage, title: String)
	let dataSource: BasicCollectionViewDataSource<VideoLibraryCell, DataType>
	
	init(items: [DataType]? = nil) {
		var resultItems: [DataType]
		if let items = items {
			resultItems = items
		} else {
			resultItems = Array(repeating: (image: #imageLiteral(resourceName: "videoLibraryTest"), title: "Спасатели жирабу"), count: 10)
		}
		
		dataSource = .init(items: resultItems)
	}
}

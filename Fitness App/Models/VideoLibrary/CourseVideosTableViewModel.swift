//
//  CourseVideosTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CourseVideosTableViewModel {
	typealias DataType = (image: UIImage, title: String, subtitle: String)
	let dataSource: BasicTableViewDataSource<CourseVideoCell, DataType>
	
	init(items: [DataType]? = nil) {
		var resultItems: [DataType]
		if let items = items {
			resultItems = items
		} else {
			resultItems = Array(repeating: (image: #imageLiteral(resourceName: "courseVideoExample"), title: "Спасатели жирабу", subtitle: "Прощай сладкое"), count: 10)
		}
		
		dataSource = .init(items: resultItems)
	}
	
	func getTitleAtIndex(_ index: Int) -> String {
		return dataSource.getItemAtIndex(index)?.title ?? ""
	}
}


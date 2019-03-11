//
//  CourseVideosTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CourseVideosTableViewModel {
	let dataSource: BasicTableViewDataSource<CourseVideoCell, Video>
	
	init(videos: [Video]) {
		dataSource = .init(items: videos)
	}
	
	func getVideoAtIndex(_ index: Int) -> Video? {
		return dataSource.getItemAtIndex(index)
	}
}


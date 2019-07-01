//
//  CourseVideosView.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol CourseVideosView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	func showVideoDetails(_ video: Video)
}

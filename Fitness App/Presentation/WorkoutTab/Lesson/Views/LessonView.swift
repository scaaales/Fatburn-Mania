//
//  LessonView.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol LessonView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	func setTitle(_ title: String,
				  lessonName: String,
				  description: String,
				  digitOfTheDay: String)
	func hideAllViews()
	func showAllViews()
	func setupForNewsState()
	func setPhoto(from urlString: String)
	func setVideo(from urlString: String)
}

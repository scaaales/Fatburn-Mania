//
//  LessonView.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol LessonView: View, TableViewUpdatable {
	func setTitle(_ title: String)
	func setLessonName(_ name: String)
	func setDescription(_ text: String)
	func loadVideoRequest(_ urlRequest: URLRequest)
}

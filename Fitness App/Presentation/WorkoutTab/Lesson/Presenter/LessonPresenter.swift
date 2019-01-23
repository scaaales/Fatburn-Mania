//
//  LessonPresenter.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class LessonPresenter<V: LessonView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var lesson: Lesson!
	
	required init(view: View) {
		self.view = view
	}
	
	func setLesson(_ lesson: Lesson) {
		self.lesson = lesson
	}
	
	func getLesson() {
		
	}
}

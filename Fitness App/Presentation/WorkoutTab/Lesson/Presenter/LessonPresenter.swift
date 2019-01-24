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
	private var viewModel: LessonsTableViewModel!
	
	required init(view: View) {
		self.view = view
	}
	
	func setLesson(_ lesson: Lesson) {
		self.lesson = lesson
	}
	
	func getLesson() {
		view.setTitle("Week 1 day 5",
					  lessonName: lesson.title,
					  description: lesson.description)
		
		let url = URL(string: "https://www.youtube.com/embed/\(lesson.videoID)?playsinline=1")!
		let urlRequest = URLRequest(url: url)
		view.loadVideoRequest(urlRequest)
		
		viewModel = .init(exercises: lesson.exercises)
		view.setTableViewDataSource(viewModel.dataSource)
		view.update()
	}
}

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
	private var dataSoruce: BasicTableViewDataSource<ExerciseCell, Exercise>!
	
	required init(view: View) {
		self.view = view
	}
	
	func setLesson(_ lesson: Lesson) {
		self.lesson = lesson
	}
	
	func getLesson() {
		view.setTitle("Week 1 day 5")
		view.setLessonName(lesson.title)
		view.setDescription(lesson.description)
		let url = URL(string: "https://www.youtube.com/embed/\(lesson.videoID)?playsinline=1")!
		let urlRequest = URLRequest(url: url)
		view.loadVideoRequest(urlRequest)
		
		dataSoruce = .init(items: lesson.exercises)
		view.setTableViewDataSource(dataSoruce)
		view.update()
	}
}

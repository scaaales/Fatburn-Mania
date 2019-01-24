//
//  WorkoutPresenter.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class WorkoutPresenter<V: WorkoutView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: WorkoutTableViewModel!
	private var lessons = [Lesson]()
	
	required init(view: View) {
		self.view = view
	}
	
	func getSeasons() {
		let testSeasons = ["0", "1", "2", "3", "4", "5", "6"]
		view.setSegments(titles: testSeasons)
		
		lessons.removeAll()
		
		let exrecises = Exercise.testExercises
		
		for season in testSeasons {
			let testLessonYellow = Lesson(title: "Продолжаем готовиться к сезону",
										  date: .getDate(from: "2018 10 18"),
										  image: #imageLiteral(resourceName: "yellowFier"),
										  season: Int(season)!,
										  description: .loremIpsumConstant,
										  exercises: exrecises,
										  videoID: "HfeervqhY9Y")
			
			let testLessonGreen = Lesson(title: "Week 1 day 5",
										 date: .getDate(from: "2018 10 18"),
										 image: #imageLiteral(resourceName: "greenNewspapper"),
										 season: Int(season)!,
										 description: .loremIpsumConstant,
										 exercises: exrecises,
										 videoID: "HfeervqhY9Y")
			
			let numberOfRepeating = Int.random(in: 2...5)
			for _ in 0...numberOfRepeating {
				lessons.append(testLessonYellow)
				lessons.append(testLessonGreen)
			}
		}
		
		getLessonsForSeason(at: 0)
	}
	
	func getLessonsForSeason(at index: Int) {
		let currentSeasonLessons = lessons.filter{ $0.season == index }
		if let viewModel = self.viewModel {
			viewModel.replaceLessons(with: currentSeasonLessons)
		} else {
			viewModel = .init(lessons: currentSeasonLessons)
			view.setTableViewDataSource(viewModel.dataSource)
		}
		
		view.update()
	}
	
	func getLessonAt(index: Int) -> Lesson {
		return viewModel.getLessonAtIndex(index)
	}
	
}

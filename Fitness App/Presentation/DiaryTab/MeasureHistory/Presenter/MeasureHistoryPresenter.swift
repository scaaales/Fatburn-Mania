//
//  MeasureHistoryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class MeasureHistoryPresenter<V: MeasureHistoryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var dataSource: BasicTableViewDataSource<MeasureHistoryCell, MeasureHistory>!
	
	required init(view: View) {
		self.view = view
	}
	
	func getHistory() {
//		let measurements = Measurements(chest: 100,
//										waist: 60,
//										thighs: 90,
//										hip: 25,
//										weight: 60)
//		let testMeasureHistory = MeasureHistory(date: .init(day: 12,
//															month: 10,
//															year: 2018),
//												measurements: measurements)
//		let testHistory = Array(repeating: testMeasureHistory, count: 3)
//		dataSource = .init(items: testHistory)
//		view.setTableViewDataSource(dataSource)
//		view.update()
	}
}

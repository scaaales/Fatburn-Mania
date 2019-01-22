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
		let testMeasureHistory = MeasureHistory(date: .getDate(from: "2018 10 12"),
												cheshMeasurement: 100,
												waistMeasurement: 60,
												thigsMeasurement: 90,
												hipMeasurement: 25,
												waightMeasurement: 60)
		let testHistory = Array(repeating: testMeasureHistory, count: 3)
		dataSource = .init(items: testHistory)
		view.setTableViewDataSource(dataSource)
		view.update()
	}
}

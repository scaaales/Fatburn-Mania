//
//  CoinsHistoryTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class CoinsHistoryTableViewModel {
	let dataSource: BasicTableViewDataSource<CoinsHistoryCell, CoinsHistory>
	
	init(items: [CoinsHistory]? = nil) {
		var resultCoinsHistory: [CoinsHistory]
		if let items = items {
			resultCoinsHistory = items
		} else {
			let octobersTestHistory = Array(repeating: CoinsHistory(reasonAdded: "Steps", numberOfCoinsAdded: 7, date: .getDate(from: "2018 10 18")), count: 4)
			let novembersTestHistory = Array(repeating: CoinsHistory(reasonAdded: "Steps", numberOfCoinsAdded: 7, date: .getDate(from: "2018 11 18")), count: 4)
			let desemberTestHistory = Array(repeating:  CoinsHistory(reasonAdded: "Steps", numberOfCoinsAdded: 7, date: .getDate(from: "2018 12 18")), count: 4)
			let januaryTestHistory = Array(repeating:  CoinsHistory(reasonAdded: "Steps", numberOfCoinsAdded: 7, date: .getDate(from: "2019 01 10")), count: 2)
			
			let birthdayTestHistory = CoinsHistory(reasonAdded: "Birthday", numberOfCoinsAdded: 10, date: .getDate(from: "2018 10 22"))
			let anotherTestHistory = CoinsHistory(reasonAdded: "Test", numberOfCoinsAdded: 15, date: .getDate(from: "2018 10 1"))
			
			resultCoinsHistory = [anotherTestHistory]
			resultCoinsHistory.append(contentsOf: octobersTestHistory)
			resultCoinsHistory.append(contentsOf: novembersTestHistory)
			resultCoinsHistory.append(contentsOf: desemberTestHistory)
			resultCoinsHistory.append(contentsOf: januaryTestHistory)
			resultCoinsHistory.append(birthdayTestHistory)
		}
		
		let sections = CoinsHistoryTableViewModel.getSectionsFrom(coinsHistory: resultCoinsHistory)
		
		dataSource = .init(sections: sections)
	}
	
	private static func getSectionsFrom(coinsHistory: [CoinsHistory]) -> [[CoinsHistory]] {
		var result = [[CoinsHistory]]()
		
		let monthsDictionary = Dictionary(grouping: coinsHistory, by: { $0.date.month })
		for (_, coinsHistory) in monthsDictionary {
			result.append(coinsHistory.sorted(by: { $0.date < $1.date }))
		}
		
		result.sort(by: { $0.first!.date > $1.first!.date })
		
		return result
	}
	
	func getMonthWithEaryForSection(_ section: Int) -> String {
		let item = dataSource.getItemAtIndex(0, in: section)
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM yyyy"
		return formatter.string(from: item.date)
	}
	
}


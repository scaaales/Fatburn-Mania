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
	
	init(items: [CoinsHistory]) {
		let sections = CoinsHistoryTableViewModel.getSectionsFrom(coinsHistory: items)
		
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



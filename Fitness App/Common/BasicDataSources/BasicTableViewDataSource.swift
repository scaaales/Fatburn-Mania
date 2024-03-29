//
//  BasicTableViewDataSource.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class BasicTableViewDataSource<CellType: UITableViewCell, DataType>: NSObject, UITableViewDataSource where CellType: ConfigurableCell, CellType.DataType == DataType {
	
	private var sections: [[DataType]]
	
	convenience init(items: [DataType]) {
		self.init(sections: [items])
	}
	
	init(sections: [[DataType]]) {
		self.sections = sections
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = sections[indexPath.section][indexPath.row]
		let configurator = CellsConfigurator<CellType, DataType>(item: item)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseId, for: indexPath)
		
		configurator.configure(cell: cell)
		
		return cell
	}
	
	func getItemAtIndex(_ index: Int, in section: Int = 0) -> DataType? {
		return sections[section][safe: index]
	}
	
	func getItem(where condition: (DataType) -> Bool) -> DataType? {
		return sections[0].first(where: condition)
	}
	
	func addItem(_ item: DataType, at index: Int) {
		sections[0].insert(item, at: index)
	}
	
	func replaceItems(with newItems: [DataType]) {
		sections = [newItems]
	}
	
	func append(contentsOf newItems: [DataType]) {
		sections[0].append(contentsOf: newItems)
	}
	
	func numberOfItems() -> Int {
		return sections[0].count
	}
	
}

//
//  BasicTableViewDataSource.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class BasicTableViewDataSource<CellType: UITableViewCell, DataType>: NSObject, UITableViewDataSource where CellType: ConfigurableCell, CellType.DataType == DataType {
	
	private let items: [DataType]
	
	init(items: [DataType]) {
		self.items = items
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = items[indexPath.row]
		let configurator = CellsConfigurator<CellType, DataType>(item: item)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseId, for: indexPath)
		
		configurator.configure(cell: cell)
		
		return cell
	}
	
	func getItemAtIndex(_ index: Int) -> DataType {
		return items[index]
	}
}

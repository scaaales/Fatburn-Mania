//
//  CellConfigurator.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

protocol CellConfigurator {
	static var reuseId: String { get }
	func configure(cell: UITableViewCell)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
	static var reuseId: String { return String(describing: CellType.self) }
	
	let item: DataType?
	
	init(item: DataType? = nil) {
		self.item = item
	}
	
	func configure(cell: UITableViewCell) {
		if let item = item {
			(cell as? CellType)?.configure(data: item)
		} else {
			(cell as? CellType)?.configure()
		}
	}
}

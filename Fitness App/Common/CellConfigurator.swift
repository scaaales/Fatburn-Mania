//
//  CellConfigurator.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

protocol CellConfigurator {
	var reuseId: String { get }
	func configure(cell: UITableViewCell)
	func configure(cell: UICollectionViewCell)
}

class CellsConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType {
	var reuseId: String { return String(describing: CellType.self) }
	
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
	
	func configure(cell: UICollectionViewCell) {
		if let item = item {
			(cell as? CellType)?.configure(data: item)
		} else {
			(cell as? CellType)?.configure()
		}
	}
}



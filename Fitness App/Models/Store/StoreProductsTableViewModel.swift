//
//  StoreProductsTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class StoreProductsTableViewModel {
	typealias DataType = StoreItemCell.DataType
	
	let dataSource: BasicTableViewDataSource<StoreItemCell, DataType>
	
	init(items: [Product]) {
		dataSource = .init(items: items)
	}
	
	func getProduct(with id: Int) -> Product {
		return dataSource.getItem(where: { $0.id == id })!
	}
	
}

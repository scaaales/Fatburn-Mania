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
	
	init(items: [Product]? = nil) {
		var resultProducts: [Product]
		if let items = items {
			resultProducts = items
		} else {
			let wallpapers = Product(name: "Обои на рабочий стол",
									 description: "Пакет из 16 обоев на рабочий стол телефона.\nЗдесь все: Юля, Смольный, Фирменная символика!",
									 price: 1000,
									 picture: #imageLiteral(resourceName: "wallpapersExample"))
			let bicycle = Product(name: "Горный велосипед",
								  description: "Пакет из 16 обоев на рабочий стол телефона.\nЗдесь все: Юля, Смольный, Фирменная символика!",
								  price: 25000,
								  picture: #imageLiteral(resourceName: "bicycleExample"))
			resultProducts = [wallpapers, bicycle, wallpapers]
		}
		
		let resultItems = resultProducts.enumerated().map({ (product: $0.element, row: $0.offset) })
		
		dataSource = .init(items: resultItems)
	}
	
}

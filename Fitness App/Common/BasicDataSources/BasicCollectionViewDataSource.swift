//
//  BasicCollectionViewDataSource.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class BasicCollectionViewDataSource<CellType: UICollectionViewCell, DataType>: NSObject, UICollectionViewDataSource where CellType: ConfigurableCell, CellType.DataType == DataType {
	
	private let items: [DataType]
	
	init(items: [DataType]) {
		self.items = items
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = items[indexPath.row]
		let configurator = CellsConfigurator<CellType, DataType>(item: item)
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseId, for: indexPath)
		
		configurator.configure(cell: cell)
		
		return cell
	}
}


//
//  VideoLibraryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class VideoLibraryPresenter<V: VideoLibraryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	let test = Test()
	
	required init(view: View) {
		self.view = view
	}
	
	func getVideos() {
		view.setCollectionViewDataSource(test)
		view.update()
	}
}

class Test: NSObject, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = CellsConfigurator<VideoLibraryCell, (image: UIImage, title: String)>(item: (image: #imageLiteral(resourceName: "videoLibraryTest"), title: "Спасатели жирабу"))
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseId, for: indexPath)
		
		item.configure(cell: cell)
		
		return cell
	}
}

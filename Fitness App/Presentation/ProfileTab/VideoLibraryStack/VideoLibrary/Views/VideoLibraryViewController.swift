//
//  VideoLibraryViewController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class VideoLibraryViewController: UIViewController {
	var presenter: VideoLibraryPresenter<VideoLibraryViewController>!
	
	@IBOutlet private weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
		presenter.getVideos()
	}
	
	func setupCollectionView() {
		collectionView.delegate = self
	}
	
}

extension VideoLibraryViewController: VideoLibraryView {
	func update() {
		collectionView.reloadData()
	}
	
	func setCollectionViewDataSource(_ dataSource: UICollectionViewDataSource) {
		collectionView.dataSource = dataSource
	}
}

extension VideoLibraryViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath.row)
	}
}

extension VideoLibraryViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (UIScreen.main.bounds.width - 60)/2
		let height = (width / 3 * 2) + 22
		return CGSize(width: width, height: height)
	}
}


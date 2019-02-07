//
//  TutorialViewController.swift
//  Fitness App
//
//  Created by scales on 1/4/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
	
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var pageControl: UIPageControl!
	
	private var dataSource: BasicCollectionViewDataSource<TutorialCell, UIImage>!
	
	var parrentController: UIViewController?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupCollectionView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
		super.viewWillAppear(animated)
	}

	private func setupDataSource() {
		var items = [UIImage]()
		for page in 1...pageControl.numberOfPages {
			items.append(UIImage(named: "tutorial\(page)")!)
		}
		
		dataSource = .init(items: items)
	}
	
	private func setupCollectionView() {
		setupDataSource()
		collectionView.dataSource = dataSource
		collectionView.delegate = self
		
		collectionView.superview?.makeCornerRadius(16)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(next(_:)))
		collectionView.addGestureRecognizer(tapGesture)
	}
	
	@IBAction private func prev(_ sender: Any) {
		let nextIndex = max(pageControl.currentPage - 1, 0)
		let indexPath = IndexPath(item: nextIndex, section: 0)
		pageControl.currentPage = nextIndex
		collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
	
	@IBAction private func next(_ sender: Any) {
		let nextIndex = min(pageControl.currentPage + 1, pageControl.numberOfPages - 1)
		let indexPath = IndexPath(item: nextIndex, section: 0)
		if pageControl.currentPage + 2 > pageControl.numberOfPages {
			showMainScreen()
		} else {
			pageControl.currentPage = nextIndex
			collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		}
	}
	
	private func showMainScreen() {
		performSegue(withIdentifier: .presentMainTabBarSegueIdentifier, sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tabBarController = segue.destination as? TabBarViewController,
			let navigationController = self.navigationController {
			tabBarController.presentedNavigationController = navigationController
		}
	}
	
}


extension TutorialViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
}

// MARK: - UIScrollViewDelegate
extension TutorialViewController {
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let x = targetContentOffset.pointee.x
		pageControl.currentPage = Int(x / collectionView.frame.width)
	}
}


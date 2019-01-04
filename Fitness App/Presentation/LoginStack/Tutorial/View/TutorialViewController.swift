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
	
	var parrentNavigationController: UINavigationController?
	
	private var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupCollectionView()
    }
	
	private func setupCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		
		collectionView.superview?.layer.cornerRadius = 16
		collectionView.superview?.layer.masksToBounds = true
		
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
		guard let navigationController = UIStoryboard.diaryTab.instantiateInitialViewController() as? NavigationController,
			let diaryVC = navigationController.viewControllers.first else { return }
		parrentNavigationController?.setViewControllers([diaryVC], animated: false)
		dismiss(animated: true)
	}
	
}

extension TutorialViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = UIImage(named: "tutorial\(indexPath.row + 1)")
		
		let cellConfigurator: CellsConfigurator<TutorialCell, UIImage>  = .init(item: item)
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellConfigurator.reuseId, for: indexPath)
		cellConfigurator.configure(cell: cell)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pageControl.numberOfPages
	}
}

extension TutorialViewController: UICollectionViewDelegate {
	
	
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


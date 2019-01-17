//
//  CollageViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import Photos

class CollageViewController: UIViewController {
	var presenter: CollagePresenter<CollageViewController>!
	
	@IBOutlet private weak var leftImageView: UIImageView!
	@IBOutlet private weak var rightImageView: UIImageView!
	@IBOutlet private weak var addLeftImageButton: UIButton!
	@IBOutlet private weak var addRightImageButton: UIButton!
	
	@IBOutlet private weak var leftScrollView: UIScrollView!
	@IBOutlet private weak var leftImageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet private weak var leftImageViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet private weak var leftImageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet private weak var leftImageViewTrailingConstraint: NSLayoutConstraint!
	
	@IBOutlet private weak var rightScrollView: UIScrollView!
	@IBOutlet private weak var rightImageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet private weak var rightImageViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet private weak var rightImageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet private weak var rightImageViewTrailingConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		leftImageView.layer.masksToBounds = true
		rightImageView.layer.masksToBounds = true
		
		leftScrollView.delegate = self
		rightScrollView.delegate = self
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		updateZoomForScrollViews()
	}
	
	@IBAction private func addLeftImageTapped() {
		presenter.getImageForLeftPart()
	}
	
	@IBAction private func addRightImageTapped() {
		presenter.getImageForRightPart()
	}
	
	@IBAction private func rotateLeftImageLeftTapped() {
		
	}
	
	@IBAction private func rotateLeftImageRightTapped() {
		
	}
	
	@IBAction private func rotateRightImageLeftTapped() {
		
	}
	
	@IBAction private func rotateRightImageRightTapped() {
		
	}
	
	@IBAction private func saveTapped() {
		presenter.saveImages(leftImage: leftImageView.image,
							 rightImage: rightImageView.image)
	}
	
	private func updateMinZoomScaleForSize(_ size: CGSize,
										   imageView: UIImageView,
										   scrollView: UIScrollView) {
		let widthScale = size.width / imageView.bounds.width
		let heightScale = size.height / imageView.bounds.height
		let minScale = min(widthScale, heightScale)
		
		scrollView.minimumZoomScale = minScale
		scrollView.maximumZoomScale = 2
		scrollView.zoomScale = minScale
	}
	
	private func updateConstraintsForSize(_ size: CGSize,
										  imageView: UIImageView) {
		let yOffset = max(0, (size.height - imageView.frame.height) / 2)
		let xOffset = max(0, (size.width - imageView.frame.width) / 2)
		if imageView === leftImageView {
			leftImageViewTopConstraint.constant = yOffset
			leftImageViewBottomConstraint.constant = yOffset
			leftImageViewLeadingConstraint.constant = xOffset
			leftImageViewTrailingConstraint.constant = xOffset
		} else {
			rightImageViewTopConstraint.constant = yOffset
			rightImageViewBottomConstraint.constant = yOffset
			rightImageViewLeadingConstraint.constant = xOffset
			rightImageViewTrailingConstraint.constant = xOffset
		}
		view.layoutIfNeeded()
		
	}
	
	private func updateZoomForScrollViews() {
		guard let leftScrollViewContainer = leftScrollView.superview,
			let rightScrollViewContrainer = rightScrollView.superview else { return }
		updateMinZoomScaleForSize(leftScrollViewContainer.bounds.size,
								  imageView: leftImageView,
								  scrollView: leftScrollView)
		updateMinZoomScaleForSize(rightScrollViewContrainer.bounds.size,
								  imageView: rightImageView,
								  scrollView: rightScrollView)
	}
	
}

extension CollageViewController: CollageView {
	var viewControllerToPresentPicker: UIViewController {
		return self
	}
	
	
	func hideAddLeftPartButton() {
		addLeftImageButton.isHidden = true
	}
	
	func hideAddRightPartButton() {
		addRightImageButton.isHidden = true
	}
	
	func setImageForLeftPart(_ image: UIImage) {
		leftImageView.image = image
		leftImageView.bounds.size = image.size
	}
	
	func setImageForRightPart(_ image: UIImage) {
		rightImageView.image = image
		rightImageView.bounds.size = image.size
	}
	
	func presentErrorSaving() {
		let alertController = UIAlertController(title: "Error saving collage", message: "Please add both left and right image's", preferredStyle: .alert)
		alertController.addAction(.init(title: "Ok", style: .cancel))
		present(alertController, animated: true)
	}
	
	func closeItself() {
		navigationController?.popViewController(animated: true)
	}
}

extension CollageViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		if scrollView === leftScrollView {
			return leftImageView
		} else {
			return rightImageView
		}
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		if scrollView === leftScrollView {
			updateConstraintsForSize(leftScrollView.bounds.size, imageView: leftImageView)
		} else {
			updateConstraintsForSize(rightScrollView.bounds.size, imageView: rightImageView)
		}
	}
	
}

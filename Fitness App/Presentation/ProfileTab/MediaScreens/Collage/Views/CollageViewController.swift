//
//  CollageViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CollageViewController: UIViewController {
	var presenter: CollagePresenter<CollageViewController>!
	
	@IBOutlet private weak var leftImageView: UIImageView!
	@IBOutlet private weak var rightImageView: UIImageView!
	@IBOutlet private weak var addLeftImageButton: UIButton!
	@IBOutlet private weak var addRightImageButton: UIButton!
	@IBOutlet private weak var saveButton: UIButton!
	
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
	
	@IBOutlet private weak var collageViewContainerStackView: UIStackView!
	
	private var leftImageRotationAngle: CGFloat = 0
	private var rightImageRotationAngle: CGFloat = 0
	
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
		guard leftImageView.image != nil else { return }
		let rotationAngle = -CGFloat.pi / 2
		rotate(imageView: leftImageView, by: rotationAngle, oldAngle: &leftImageRotationAngle)
	}
	
	@IBAction private func rotateLeftImageRightTapped() {
		guard leftImageView.image != nil else { return }
		let rotationAngle = CGFloat.pi / 2
		rotate(imageView: leftImageView, by: rotationAngle, oldAngle: &leftImageRotationAngle)
	}
	
	@IBAction private func rotateRightImageLeftTapped() {
		guard rightImageView.image != nil else { return }
		let rotationAngle = -CGFloat.pi / 2
		rotate(imageView: rightImageView, by: rotationAngle, oldAngle: &rightImageRotationAngle)
	}
	
	@IBAction private func rotateRightImageRightTapped() {
		guard rightImageView.image != nil else { return }
		let rotationAngle = CGFloat.pi / 2
		rotate(imageView: rightImageView, by: rotationAngle, oldAngle: &rightImageRotationAngle)
	}
	
	@IBAction private func saveTapped() {
		presenter.saveImages(leftImage: leftImageView.image,
							 rightImage: rightImageView.image)
	}
	
	private func updateMinZoomScaleForSize(_ size: CGSize,
										   imageView: UIImageView,
										   scrollView: UIScrollView) {
		let widthScale = (size.width - 2) / imageView.bounds.width
		let heightScale = (size.height - 2) / imageView.bounds.height
		let minScale = max(widthScale, heightScale)
		
		scrollView.minimumZoomScale = minScale
		scrollView.maximumZoomScale = minScale * 2
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
	
	private func normalizeAngle(_ angle: inout CGFloat) {
		if angle <= -CGFloat.pi * 2 {
			angle += CGFloat.pi * 2
		} else if angle >= CGFloat.pi * 2 {
			angle -= CGFloat.pi * 2
		}
	}
	
	private func rotate(imageView: UIImageView, by angle: CGFloat, oldAngle: inout CGFloat) {
		oldAngle += angle
		normalizeAngle(&oldAngle)
		imageView.rotateImageToAngle(angle: oldAngle)
		imageView.bounds.size = imageView.image!.size
	}
	
}

extension CollageViewController: CollageView {
	var viewControllerToPresentPicker: UIViewController {
		return self
	}
	
	var collageViewContainer: UIView {
		return collageViewContainerStackView
	}
	
	var collageViewSize: CGSize {
		return CGSize(width: collageViewContainerStackView.bounds.width,
					  height: collageViewContainerStackView.bounds.height - collageViewYOffset * 2)
	}
	
	var collageViewYOffset: CGFloat {
		return leftScrollView.superview!.frame.minY
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
	
	func presentPhotoSharing(_ image: UIImage) {
		let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = saveButton
		activityViewController.completionWithItemsHandler = { [weak self] _, completed, _, _ in
			if completed {
				self?.presenter.collageSaved()
			}
		}
		present(activityViewController, animated: true)
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


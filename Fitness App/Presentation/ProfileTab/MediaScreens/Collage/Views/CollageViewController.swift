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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		leftImageView.layer.masksToBounds = true
		rightImageView.layer.masksToBounds = true
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
	
	@IBAction private func reduceTapped() {
		
	}
	
	@IBAction private func zoopTapped() {
		
	}
	
	@IBAction private func saveTapped() {
		
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
	}
	
	func setImageForRightPart(_ image: UIImage) {
		rightImageView.image = image
	}
	
}



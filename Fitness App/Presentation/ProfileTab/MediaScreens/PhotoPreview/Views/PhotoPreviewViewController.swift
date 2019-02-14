//
//  PhotoPreviewViewController.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class PhotoPreviewViewController: UIViewController {
	var presenter: PhotoPreviewPresenter<PhotoPreviewViewController>!
	
	var photo: UIImage!
	@IBOutlet private weak var photoImageView: UIImageView!
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		photoImageView.image = photo
	}
	
	@IBAction private func saveTapped() {
		presenter.savePhoto()
	}
	
	@IBAction func closeItself() {
		dismiss(animated: true)
	}
	
}

extension PhotoPreviewViewController: PhotoPreviewView {
	
}



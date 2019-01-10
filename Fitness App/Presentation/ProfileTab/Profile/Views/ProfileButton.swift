//
//  ProfileButton.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ProfileButton: UIView {

	@IBOutlet weak var imageView: UIImageView! {
		didSet {
			makeRoundedWithShadow()
		}
	}

	func makeRoundedWithShadow() {
		let cornerRadius = imageView.bounds.height/2
		
		let shadowView = UIView(frame: imageView.frame)
		shadowView.backgroundColor = .white
		shadowView.layer.cornerRadius = cornerRadius
		shadowView.layer.shadowColor = UIColor.black.cgColor
		shadowView.layer.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: cornerRadius).cgPath
		shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
		shadowView.layer.shadowRadius = 4
		shadowView.layer.shadowOpacity = 0.3
		shadowView.clipsToBounds = false
		
		imageView.layer.cornerRadius = cornerRadius
		imageView.clipsToBounds = true
		
		addSubview(shadowView)
		bringSubviewToFront(imageView)
	}
	
}

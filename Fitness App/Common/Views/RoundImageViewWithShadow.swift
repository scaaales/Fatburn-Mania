//
//  RoundImageViewWithShadow.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class RoundImageViewWithShadow: UIImageView {

	@IBInspectable var shadowOpacity: Float = 0.3
	@IBInspectable var shadowRaidus: CGFloat = 4
	
	override func awakeFromNib() {
		super.awakeFromNib()
		makeRoundWithShadow()
	}
	
	private func makeRoundWithShadow() {
		let cornerRadius = bounds.height/2
		
		let shadowView = UIView(frame: frame)
		shadowView.backgroundColor = .white
		shadowView.layer.cornerRadius = cornerRadius
		shadowView.layer.shadowColor = UIColor.black.cgColor
		shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
		shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
		shadowView.layer.shadowRadius = shadowRaidus
		shadowView.layer.shadowOpacity = shadowOpacity
		shadowView.clipsToBounds = false
		
		layer.cornerRadius = cornerRadius
		clipsToBounds = true
		
		let preveusSubviews = superview?.subviews
		
		superview?.addSubview(shadowView)
		superview?.bringSubviewToFront(self)
		
		preveusSubviews?.forEach { self.superview?.bringSubviewToFront($0) }
		
		shadowView.translatesAutoresizingMaskIntoConstraints = false
		shadowView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		shadowView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		shadowView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
		shadowView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
	}

}

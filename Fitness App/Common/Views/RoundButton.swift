//
//  RoundButton.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
	
	@IBInspectable var isCircle: Bool = true
	@IBInspectable var cornerRadius: CGFloat = 0
	
	private var shadowView: UIView!
	
	override var isHidden: Bool {
		didSet {
			shadowView?.isHidden = isHidden
		}
	}
	
	private var shadowAdded = false

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		if shadowAdded { return }
		shadowAdded = true
		
		let cornerRadius = isCircle ? bounds.height/2 : self.cornerRadius
		
		shadowView = UIView(frame: self.frame)
		shadowView.backgroundColor = .white
		shadowView.layer.cornerRadius = cornerRadius
		shadowView.layer.shadowColor = UIColor.black.cgColor
		shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
		shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
		shadowView.layer.shadowOpacity = 0.4
		shadowView.layer.shadowRadius = 4
		shadowView.layer.masksToBounds = true
		shadowView.clipsToBounds = false
		
		shadowView.isHidden = isHidden
		
		layer.cornerRadius = cornerRadius
		layer.masksToBounds = true
		
		self.superview?.addSubview(shadowView)
		self.superview?.bringSubviewToFront(self)
		
		shadowView.translatesAutoresizingMaskIntoConstraints = false
		shadowView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		shadowView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		shadowView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
		shadowView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
	}
	
	override func removeFromSuperview() {
		super.removeFromSuperview()
		shadowView?.removeFromSuperview()
	}

}

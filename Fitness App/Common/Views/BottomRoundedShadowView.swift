//
//  BottomRoundedShadowView.swift
//  Fitness App
//
//  Created by scales on 1/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class BottomRoundedShadowView: UIView {
	
	private var isInitialized = false
	private var borderView: UIView!
	
	override func awakeFromNib() {
		borderView = UIView()
		borderView.backgroundColor = backgroundColor
		backgroundColor = .clear
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		if !isInitialized {
			makeRoundedBottom()
			addShadow()
			isInitialized = true
		}
	}
	
	private func makeRoundedBottom() {
		borderView.frame = bounds
		
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 30, height: 30))
		let newMaskLayer = CAShapeLayer()
		newMaskLayer.path = path.cgPath
		borderView.layer.mask = newMaskLayer
		borderView.layer.masksToBounds = true
		
		let preveusSubviews = subviews
		
		addSubview(borderView)
		
		preveusSubviews.forEach { self.bringSubviewToFront($0) }
	}
	
	private func addShadow() {
		layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 30).cgPath
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowOpacity = 0.4
		layer.shadowRadius = 4
	}

}

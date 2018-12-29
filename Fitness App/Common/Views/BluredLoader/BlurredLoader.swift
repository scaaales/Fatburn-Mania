//
//  BlurredLoader.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class BlurredLoader: UIView {

	private var contentView: UIView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		xibSetup()
	}
	
	private func xibSetup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		contentView = view
		view.layer.cornerRadius = 15
		view.clipsToBounds = true
	}
	
	private func loadViewFromNib() -> UIView? {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "BlurredLoader", bundle: bundle)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func startAnimating() {
		isHidden = false
		activityIndicator.startAnimating()
	}
	
	func stopAnimating() {
		activityIndicator.stopAnimating()
		isHidden = true
	}
}

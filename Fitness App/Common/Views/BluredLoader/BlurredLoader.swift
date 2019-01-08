//
//  BlurredLoader.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class BlurredLoader: UIView {

	private var contentView: UIView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		xibSetup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
	private func addCornerRadius() {
		contentView.layer.cornerRadius = 15
		contentView.clipsToBounds = true
	}
	
	private func xibSetup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		contentView = view
		addCornerRadius()
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
	
	func centerInto(view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			centerXAnchor.constraint(equalTo: view.centerXAnchor),
			centerYAnchor.constraint(equalTo: view.centerYAnchor),
			heightAnchor.constraint(equalToConstant: 100),
			widthAnchor.constraint(equalToConstant: 100)
			])
	}
}

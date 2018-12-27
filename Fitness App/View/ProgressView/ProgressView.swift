//
//  ProgressView.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class ProgressView: UIView {
	private var isProgressRoudned = false
	private var contentView: UIView?
	
	@IBOutlet private weak var progressView: UIProgressView!
	@IBOutlet private weak var startValueLabel: UILabel!
	@IBOutlet private weak var endValueLabel: UILabel!
	@IBOutlet private weak var resultLabel: UILabel!
	@IBOutlet private weak var goalLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		xibSetup()
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		if isProgressRoudned { return }
		isProgressRoudned = true
		
		progressView.subviews.forEach { subview in
			subview.layer.masksToBounds = true
			subview.layer.cornerRadius = subview.bounds.height / 2
		}
	}
	
	private func xibSetup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		contentView = view
	}
	
	private func loadViewFromNib() -> UIView? {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "ProgressView", bundle: bundle)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func setProgress(startValue: String, endValue: String, progress: Float) {
		startValueLabel.text = startValue
		endValueLabel.text = endValue
		progressView.setProgress(progress, animated: false)
	}
	
	func setBottomLabels(hidden: Bool) {
		resultLabel.isHidden = hidden
		goalLabel.isHidden = hidden
	}

}

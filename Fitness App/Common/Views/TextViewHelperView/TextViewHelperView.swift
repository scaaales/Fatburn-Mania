//
//  TextViewHelperView.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TextViewHelperView: UIView {

	private var contentView: UIView?
	@IBOutlet private weak var prevButton: UIButton!
	@IBOutlet private weak var nextButton: UIButton!
	
	private var prevHandler: (() -> Void)!
	private var nextHandler: (() -> Void)!
	private var doneHandler: (() -> Void)!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
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
	}
	
	func setHandlers(prevHandler: @escaping () -> Void,
					 nextHandler: @escaping () -> Void,
					 doneHandler: @escaping () -> Void) {
		self.prevHandler = prevHandler
		self.nextHandler = nextHandler
		self.doneHandler = doneHandler
	}
	
	func disablePrevButton() {
		prevButton.isEnabled = false
	}
	
	func enablePrevButton() {
		prevButton.isEnabled = true
	}
	
	func disableNextButton() {
		nextButton.isEnabled = false
	}
	
	func enableNextButton() {
		nextButton.isEnabled = true
	}
	
	private func loadViewFromNib() -> UIView? {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "TextViewHelperView", bundle: bundle)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	@IBAction private func prevTapped() {
		prevHandler()
		nextButton.isEnabled = true
	}
	
	@IBAction private func nextTapped() {
		nextHandler()
		prevButton.isEnabled = true
	}
	
	@IBAction private func doneTapped() {
		doneHandler()
	}

}

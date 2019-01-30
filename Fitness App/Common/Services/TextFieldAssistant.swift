//
//  TextFieldAssistant.swift
//  Fitness App
//
//  Created by scales on 1/30/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TextFieldAssistant: NSObject {
	private let view: UIView
	private let firstResponderTag: Int
	private let lastResponderTag: Int
	var currentResponderTag: Int {
		didSet {
			if oldValue != currentResponderTag {
				makeFirstResponderView(with: currentResponderTag)
			}
			switch currentResponderTag {
			case firstResponderTag:
				textViewHelperView.disablePrevButton()
				textViewHelperView.enableNextButton()
			case lastResponderTag:
				textViewHelperView.disableNextButton()
				textViewHelperView.enablePrevButton()
			default:
				textViewHelperView.enablePrevButton()
				textViewHelperView.enableNextButton()
			}
		}
	}
	
	let textViewHelperView: TextViewHelperView
	
	init(view: UIView, firstResponderTag: Int, lastResponderTag: Int) {
		self.view = view
		self.firstResponderTag = firstResponderTag
		self.lastResponderTag = lastResponderTag
		self.currentResponderTag = firstResponderTag
		
		textViewHelperView = TextViewHelperView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
		
		super.init()
		
		textViewHelperView.setHandlers(prevHandler: { [weak self] in
			guard let self = self else { return }
			self.currentResponderTag -= 1
			}, nextHandler: { [weak self] in
				guard let self = self else { return }
				self.currentResponderTag += 1
			}, doneHandler: { [weak self] in
				self?.view.endEditing(true)
		})
	}
	
	private func makeFirstResponderView(with tag: Int) {
		let nextResponderView = self.view.viewWithTag(tag)
		nextResponderView?.becomeFirstResponder()
	}
}

extension TextFieldAssistant: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField.tag == lastResponderTag {
			view.endEditing(true)
			return true
		} else {
			let nextResponderTag = textField.tag + 1
			currentResponderTag = nextResponderTag
			return false
		}
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		currentResponderTag = textField.tag
	}
}

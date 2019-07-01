//
//  RootViewController.swift
//  Fitness App
//
//  Created by scales on 2/26/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
	
	final var tryAgainButton: UIButton?
	
	final private func createTryAgainButton() {
		let button = UIButton()
		button.setTitle("Try again", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.titleLabel?.font = .systemFont(ofSize: 14)
		
		view.addSubview(button)
		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			])
		button.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
		
		tryAgainButton = button
	}
	
	@IBAction func tryAgainTapped() {
		
	}
	
	func showTryAgainButton() {
		if tryAgainButton == nil {
			createTryAgainButton()
		}
		tryAgainButton?.isHidden = false
	}
	
	func hideTryAgainButton() {
		tryAgainButton?.isHidden = true
	}
	
}

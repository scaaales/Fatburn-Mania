//
//  CoinsAddedViewController.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CoinsAddedViewController: UIViewController {
	
	var coinsAmount: Int!
	var prevVC: UIViewController!
	
	@IBOutlet private weak var coinsLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		coinsLabel.text = "\(coinsAmount!)"
	}
	
	@IBAction private func close() {
		dismiss(animated: true) { [weak self] in
			self?.prevVC.dismiss(animated: true)
		}
	}
}


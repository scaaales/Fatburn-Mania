//
//  CoinsAddedViewController.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CoinsAddedViewController: UIViewController {
	
	@IBOutlet private weak var topLabel: UILabel!
	var coinsAmount: Int!
	var prevVC: AddNewMeasurementsViewController?
	
	var reasonAddedTextReplacement: String?
	
	@IBOutlet private weak var coinsLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		coinsLabel.text = "\(coinsAmount!)"
		if let newText = reasonAddedTextReplacement {
			topLabel.text = newText
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		SoundService.play(sound: .coins)
	}
	
	@IBAction private func close() {
		dismiss(animated: true) { [weak self] in
			self?.prevVC?.closeItself()
		}
	}
}


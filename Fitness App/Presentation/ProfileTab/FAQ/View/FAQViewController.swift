//
//  FAQViewController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

	@IBOutlet private weak var textView: UITextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		textView.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
		textView.isScrollEnabled = false
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		textView.isScrollEnabled = true
	}

}

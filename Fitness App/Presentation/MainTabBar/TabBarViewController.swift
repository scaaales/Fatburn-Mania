//
//  TabBarViewController.swift
//  Fitness App
//
//  Created by scales on 1/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

	private var isFirstLoad = true
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if isFirstLoad {
			isFirstLoad = false
			performSegue(withIdentifier: .presentLoginSegueIdentifier, sender: nil)
		}
	}

}

//
//  NavigationController.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupAppearance()
    }
	
	private func setupAppearance() {
		setupBarColor()
		setupBackButton()
	}
	
	private func setupBarColor() {
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = false
		navigationBar.backgroundColor = .white
	}
	
	private func setupBackButton() {
		navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back_navigation")
		navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back_navigation")
		navigationBar.tintColor = .black
		navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}

}

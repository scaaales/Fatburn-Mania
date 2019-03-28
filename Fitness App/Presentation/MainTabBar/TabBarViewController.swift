//
//  TabBarViewController.swift
//  Fitness App
//
//  Created by scales on 1/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
	private lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
	var presentedNavigationController: UINavigationController!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tabBar.layer.borderWidth = 0
		tabBar.layer.borderColor = UIColor.clear.cgColor
		selectedIndex = 3
		setupShadow()
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		let newTabBarHeight = defaultTabBarHeight - 7
		
		var newFrame = tabBar.frame
		newFrame.size.height = newTabBarHeight
		newFrame.origin.y = view.frame.size.height - newTabBarHeight
		
		tabBar.frame = newFrame
	}
	
	private func setupShadow() {
		let tabGradientView = UIView(frame: tabBar.bounds)
		tabGradientView.backgroundColor = UIColor.white
		tabGradientView.translatesAutoresizingMaskIntoConstraints = false
		
		tabBar.addSubview(tabGradientView)
		tabBar.sendSubviewToBack(tabGradientView)
		tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		tabGradientView.layer.shadowOffset = CGSize(width: 0, height: -3)
		tabGradientView.layer.shadowRadius = 4
		tabGradientView.layer.shadowColor = UIColor.black.cgColor
		tabGradientView.layer.shadowOpacity = 0.2
		tabBar.clipsToBounds = false
		tabBar.backgroundImage = UIImage()
		tabBar.shadowImage = UIImage()
	}

}

//
//  CollageViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CollageViewController: UIViewController {
	var presenter: CollagePresenter<CollageViewController>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
}

extension CollageViewController: CollageView {
	
}



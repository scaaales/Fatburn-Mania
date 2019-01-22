//
//  MeasureHistoryViewController.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MeasureHistoryViewController: UIViewController {
	var presenter: MeasureHistoryPresenter<MeasureHistoryViewController>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
}

extension MeasureHistoryViewController: MeasureHistoryView {
	
}



//
//  LessonViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
	var presenter: LessonPresenter<LessonViewController>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
}

extension LessonViewController: LessonView {
	
}



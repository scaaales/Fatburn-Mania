//
//  CourseVideosViewController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CourseVideosViewController: UIViewController {
	var presenter: CourseVideosPresenter<CourseVideosViewController>!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
}

extension CourseVideosViewController: CourseVideosView {
	
}



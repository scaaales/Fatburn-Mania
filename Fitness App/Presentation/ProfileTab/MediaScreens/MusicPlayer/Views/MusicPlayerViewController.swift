//
//  MusicPlayerViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {
	var presenter: MusicPlayerPresenter<MusicPlayerViewController>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
}

extension MusicPlayerViewController: MusicPlayerView {
	
}



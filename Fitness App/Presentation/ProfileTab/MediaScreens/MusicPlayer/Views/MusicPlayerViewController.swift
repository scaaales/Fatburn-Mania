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
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var volumeSlider: UISlider!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		for state in [UIControl.State.normal, .highlighted] {
			volumeSlider.setThumbImage(#imageLiteral(resourceName: "thumbWithShadow"), for: state)
		}
		setupTableView()
		presenter.getSongs()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.backgroundColor = .white
	}
	
}

extension MusicPlayerViewController: MusicPlayerView {
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func update() {
		tableView.reloadData()
	}
}

extension MusicPlayerViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 15
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 86
	}
}


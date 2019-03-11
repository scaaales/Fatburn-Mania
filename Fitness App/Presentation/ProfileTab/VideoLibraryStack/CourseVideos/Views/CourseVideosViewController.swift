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
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		presenter.getVideos()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.backgroundColor = .white
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let videoDetailVC = segue.destination as? VideoDetailsViewController,
			let video = sender as? Video {
			videoDetailVC.video = video
		}
	}
	
}

extension CourseVideosViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 10
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.getVideoDetailsForVideo(at: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension CourseVideosViewController: CourseVideosView {
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func showVideoDetails(_ video: Video) {
		performSegue(withIdentifier: .showVideoDetailsSegueIdentifier, sender: video)
	}
}



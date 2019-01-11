//
//  ProfileViewController.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
	var presenter: ProfilePresenter<ProfileViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setupTableView()
        presenter.getUser()
    }
	
	private func setupTableView() {
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 1
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.backgroundColor = .white
	}

}

extension ProfileViewController: ProfileView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
}

extension ProfileViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let title = presenter.getCellTitleFor(indexPath: indexPath)
		switch title {
		case "Coins":
			print("need to show Coins screen")
		case "Store":
			print("need to show Store screen")
		case "Video library":
			performSegue(withIdentifier: .showVideoLibrarySegueIdentifier, sender: nil)
		case "How to use the application":
			performSegue(withIdentifier: .showHowToSegueIdentifier, sender: nil)
		case "FAQ":
			performSegue(withIdentifier: .showFAQSegueIdentifier, sender: nil)
		default:
			break
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}

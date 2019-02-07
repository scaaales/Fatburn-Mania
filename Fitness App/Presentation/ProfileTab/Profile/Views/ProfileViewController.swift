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
		addLogoutButton()
    }
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.makeResizable()
		tableView.backgroundColor = .white
	}
	
	private func addLogoutButton() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let editProfileVC = segue.destination as? EditProfileViewController {
			editProfileVC.presenter.user = presenter.user
		}
	}
	
	@objc private func logoutTapped() {
		presenter.logout()
	}

}

extension ProfileViewController: ProfileView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func showLoginStack() {
		guard let loginVC = UIStoryboard.loginStack.instantiateInitialViewController() else { return }
		(tabBarController as? TabBarViewController)?.presentedNavigationController.setViewControllers([loginVC], animated: false)
		dismiss(animated: true)
	}
}

extension ProfileViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let title = presenter.getCellTitleFor(indexPath: indexPath)
		switch title {
		case "Coins":
			performSegue(withIdentifier: .showCoinsHistorySegueIdentifier, sender: nil)
		case "Store":
			performSegue(withIdentifier: .showStoreSegueIdentifier, sender: nil)
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

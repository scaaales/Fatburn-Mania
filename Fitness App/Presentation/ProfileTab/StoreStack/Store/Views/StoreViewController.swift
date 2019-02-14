//
//  StoreViewController.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
	var presenter: StorePresenter<StoreViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	var isPresentedModal = false
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		presenter.getProducts()
		if isPresentedModal {
			setupBackButton()
		}
	}
	
	private func setupBackButton() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(hide))
	}
	
	private func setupTableView() {
		tableView.makeResizable()
		tableView.backgroundColor = .white
	}
	
	@objc private func hide() {
		parent?.dismiss(animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let productDetailsVC = segue.destination as? ProductDetailViewController,
			let button = sender as? UIButton {
			let product = presenter.getProduct(with: button.tag)
			productDetailsVC.presenter.product = product
		}
	}
	
}

extension StoreViewController: StoreView {
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
}



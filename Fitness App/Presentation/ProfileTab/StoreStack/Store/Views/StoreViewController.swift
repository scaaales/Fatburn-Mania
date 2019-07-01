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
	
	private typealias SeguePassingData = (product: Product, storeApi: FitnessApi.Store)
	
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
	
	@IBAction private func readMoreTapped(_ button: UIButton) {
		presenter.readMore(for: button.tag)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let productDetailsVC = segue.destination as? ProductDetailViewController,
			let data = sender as? SeguePassingData {
			productDetailsVC.presenter.product = data.product
			productDetailsVC.presenter.storeApi = data.storeApi
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
	
	func showDetailForProduct(_ product: Product, pass storeApi: FitnessApi.Store) {
		performSegue(withIdentifier: .showProductDetailsSegueIdentifier,
					 sender: (product: product, storeApi: storeApi))
	}
}



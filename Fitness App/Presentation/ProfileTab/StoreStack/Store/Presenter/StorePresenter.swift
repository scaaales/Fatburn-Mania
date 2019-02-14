//
//  StorePresenter.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class StorePresenter<V: StoreView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: StoreProductsTableViewModel!
	private let storeApi = FitnessApi.Store()
	
	required init(view: View) {
		self.view = view
	}
	
	func getProducts() {
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else { return }
		
		view.disableUserInteraction()
		view.showLoader()
		
		storeApi.getStoreItems(token: token, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] products in
			guard let self = self else { return }
			self.viewModel = StoreProductsTableViewModel(items: products)
			self.view.setTableViewDataSource(self.viewModel.dataSource)
			self.view.update()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func getProduct(with id: Int) -> Product {
		return viewModel.getProduct(with: id)
	}
}

//
//  ProductDetailPresenter.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ProductDetailPresenter<V: ProductDetailView>: Presenter {
	typealias View = V
	
	weak var view: View!
	var product: Product!
	var storeApi: FitnessApi.Store!
	
	required init(view: View) {
		self.view = view
	}
	
	func getProduct() {
		view.showProduct(product)
	}
	
	func buyProduct() {
		view.showConfirmPopup(with: "Do you sure you want to buy \(product.title) thant costs \(product.price) coins?") { [weak self] in
			self?.startBuyRequest()
		}
	}
	
	private func startBuyRequest() {
		view.disableUserInteraction()
		view.showLoader()
		
		storeApi.butStoreItem(productId: product.id,
							  onComplete: { [weak self] in
								self?.view.enableUserInteraction()
								self?.view.hideLoader()
			}, onSuccess: { [weak self] in
				guard let product = self?.product else { return }
				self?.view.showPopup(with: nil, text: .successBoughtTextConst(name: product.title))
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
}

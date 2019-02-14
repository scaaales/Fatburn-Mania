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
	
	required init(view: View) {
		self.view = view
	}
	
	func getProduct() {
		view.showProduct(product)
	}
	
	func buyProduct() {
		print("attempting to buy \(product.title), that's cost \(product.price)")
	}
}

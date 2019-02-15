//
//  ProductDetailView.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol ProductDetailView: View, NetworkingView, PopupShowable {
	func showProduct(_ product: Product)
}

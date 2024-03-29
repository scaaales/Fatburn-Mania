//
//  StoreView.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol StoreView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	func showDetailForProduct(_ product: Product, pass storeApi: FitnessApi.Store)
}

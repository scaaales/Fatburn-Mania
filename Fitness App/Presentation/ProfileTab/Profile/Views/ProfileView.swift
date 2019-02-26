//
//  ProfileView.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol ProfileView: View, TableViewUpdatable, NetworkingView, PopupShowable {	
	func showLoginScreen()
	func reloadCellsWitoutAnimation(at row: Int)
}

//
//  ProfilePresenter.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class ProfilePresenter<V: ProfileView>: Presenter { 
	typealias View = V
	
	weak var view: View!
	private var viewModel: ProfileTableViewModel!
	
	var user: User {
		didSet {
			viewModel = .init(user: user)
		}
	}
	
	required init(view: View) {
		self.view = view
		user = User(firstName: "Sergey",
					lastName: "Kletsov",
					nickname: "scales",
					gender: .male,
					dateOfBirth: .init(day: 22, month: 10, year: 1995),
					email: "sergey.kletsov@outlook.com",
					phoneNumber: "+3 (8097) 419-64-16",
					avatar: #imageLiteral(resourceName: "user_test"),
					instagramName: "scaaales",
					country: "Ukraine",
					city: "Kiev",
					balance: 2310)
	}
	
	func getUser() {
		viewModel = .init(user: user)
		view.setTableViewDataSource(viewModel)
		view.update()
	}
	
	func getCellTitleFor(indexPath: IndexPath) -> String? {
		return viewModel.getCellTitleFor(at: indexPath.row)
	}
}

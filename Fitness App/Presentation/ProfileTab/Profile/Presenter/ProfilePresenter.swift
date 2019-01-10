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
	private var viewModel: ProfileTableViewModel {
		didSet {
			view.setTableViewDataSource(viewModel)
		}
	}
	
	required init(view: View) {
		self.view = view
		viewModel = ProfileTableViewModel()
	}
	
	func getUser() {
		let user = User(name: "Sergey Kletsov",
						gender: .male,
						age: 23,
						email: "sergey.kletsov@outlook.com",
						phoneNumber: "+3 (8097) 419-64-16",
						avatar: #imageLiteral(resourceName: "user_test"),
						instagramName: "scaaales",
						location: "Kiev, Ukraine",
						balance: 2310)
		
		viewModel = ProfileTableViewModel(user: user)
		
		view.update()
	}
	
	func getCellTitleFor(indexPath: IndexPath) -> String? {
		return viewModel.getCellTitleFor(at: indexPath.row)
	}
}

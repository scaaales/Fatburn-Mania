//
//  EditProfilePresenter.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class EditProfilePresenter<V: EditProfileView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: EditProfileTableViewModel!
	
	var user: User!
	
	required init(view: View) {
		self.view = view
	}
	
	func getUser() {
		viewModel = .init(user: user,
						  textFieldDelegate: view.textFieldDelegate,
						  datePickerView: view.getViewForDateInput(),
						  helperView: view.getHelperViewForDateInput())
		view.setTableViewDataSource(viewModel)
		view.update()
	}
	
	func getBirthdayDate() -> Date {
		return user.dateOfBirth
	}
}

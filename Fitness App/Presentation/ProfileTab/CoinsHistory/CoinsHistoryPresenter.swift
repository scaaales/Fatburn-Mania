//
//  CoinsHistoryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class CoinsHistoryPresenter<V: CoinsHistoryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: CoinsHistoryTableViewModel!
	private var profileAPI: FitnessApi.Profile!
	
	required init(view: View) {
		self.view = view
	}
	
	func getHistory() {		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else { return }
		
		view.disableUserInteraction()
		view.showLoader()
		
		profileAPI = .init(token: token)
		profileAPI.getCoinsHistory(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] coinsHistory in
			guard let self = self else { return }
			self.viewModel = .init(items: coinsHistory)
			self.view.setTableViewDataSource(self.viewModel.dataSource)
			self.view.update()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func getMonthWithEaryForSection(_ section: Int) -> String? {
		return viewModel?.getMonthWithEaryForSection(section)
	}
}

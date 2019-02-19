//
//  MeasureHistoryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class MeasureHistoryPresenter<V: MeasureHistoryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var dataSource: BasicTableViewDataSource<MeasureHistoryCell, Measurements>!
	private let diaryApi: FitnessApi.Diary
	private var offset = 0
	private var isHistoryFull = false
	private var loadingMore = false
	
	var currentNumberOfItems: Int {
		return dataSource.numberOfItems()
	}
	
	required init(view: View) {
		self.view = view
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		diaryApi = .init(token: token)
		dataSource = .init(items: [])
	}
	
	func getHistory() {
		guard !(loadingMore || isHistoryFull) else { return }
		view.showLoader()
		
		view.setTableViewDataSource(dataSource)
		
		loadingMore = true
		diaryApi.getMeasurements(at: nil, limit: 20, offset: offset, onComplete: { [weak self] in
			self?.view.hideLoader()
			self?.loadingMore = false
			}, onSuccess: { [weak self] measurements in
				if measurements.count != 20 {
					self?.isHistoryFull = true
				} else {
					 self?.offset += 1
				}
				self?.dataSource.append(contentsOf: measurements)
				self?.view.update()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
}

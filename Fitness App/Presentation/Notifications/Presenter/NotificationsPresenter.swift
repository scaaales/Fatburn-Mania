//
//  NotificationsPresenter.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class NotificationsPresenter<V: NotificationsView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var dataSource: BasicTableViewDataSource<NotificationCell, PushNotification>!
	private let notificationsApi: FitnessApi.Notifications
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		notificationsApi = .init(token: token)
	}
	
	func getNotifications() {
		view.disableUserInteraction()
		view.showLoader()
		
		notificationsApi.getNotifications(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] notifications in
			guard let self = self else { return }
			self.dataSource = .init(items: notifications)
			self.view.setTableViewDataSource(self.dataSource)
			self.view.update()
		}) { [weak self] (errorText) in
			self?.view.showErrorPopup(with: errorText)
		}
		
	}
}

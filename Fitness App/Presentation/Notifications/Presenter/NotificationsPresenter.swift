//
//  NotificationsPresenter.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class NotificationsPresenter<V: NotificationsView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var dataSource: BasicTableViewDataSource<NotificationCell, PushNotification>!
	
	required init(view: View) {
		self.view = view
	}
	
	func getNotifications() {
		let notifications = Array(repeating: PushNotification(text: "миньон Трев. поставил вам зачет в задании 1 День", date: nil), count: 4)
		dataSource = .init(items: notifications)
		view.setTableViewDataSource(dataSource)
		view.update()
	}
}

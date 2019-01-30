//
//  NotificationCell.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Notification
	
	@IBOutlet private weak var notificationTextLabel: UILabel!
	@IBOutlet private weak var timeAgoLabel: UILabel!
	
	func configure(data: Notification) {
		notificationTextLabel.text = data.text
		timeAgoLabel.text = data.date?.timeAgoDisplay ?? "29 минут назад"
	}

}

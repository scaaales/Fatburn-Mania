//
//  NotificationCell.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell, ConfigurableCell {
	typealias DataType = PushNotification
	
	@IBOutlet private weak var notificationTextLabel: UILabel!
	@IBOutlet private weak var timeAgoLabel: UILabel!
	
	func configure(data: PushNotification) {
		notificationTextLabel.text = data.text
		timeAgoLabel.text = data.date.timeAgoDisplay
	}

}

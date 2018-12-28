//
//  CalendarDateCell.swift
//  Fitness Test App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarDateCell: JTAppleCell {
	static var reuseId: String { return String(describing: CalendarDateCell.self) }
	
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var eventView: UIView!
	@IBOutlet private weak var selectedView: UIView!
	
	func configure(text: String, isSelected: Bool, hasIvent: Bool) {
		contentView.isHidden = false
		selectedView.layer.cornerRadius = selectedView.bounds.height / 2
		
		eventView.layer.cornerRadius = eventView.bounds.height / 2
		eventView.layer.borderWidth = 0.5
		eventView.layer.borderColor = #colorLiteral(red: 0.9432535768, green: 0.452998817, blue: 0.6791170239, alpha: 1).cgColor
		
		dateLabel.text = text
		set(selected: isSelected)
		set(hasIvent: hasIvent)
	}
	
	func configureEmpty() {
		contentView.isHidden = true
	}
	
	func set(selected: Bool) {
		selectedView.isHidden = !selected
		dateLabel.textColor = selected ? .white : .black
	}
	
	func set(hasIvent: Bool) {
		eventView.isHidden = !hasIvent
	}
	
}

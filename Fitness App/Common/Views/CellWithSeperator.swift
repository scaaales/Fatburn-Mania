//
//  CellWithSeperator.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CellWithSeperator: UITableViewCell {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSeperator()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addSeperator()
	}
	
	private func addSeperator() {
		let seperator = UIView(frame: .zero)
		seperator.translatesAutoresizingMaskIntoConstraints = false
		seperator.backgroundColor = .lightGrayColor
		
		contentView.addSubview(seperator)
		NSLayoutConstraint.activate([
			seperator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			seperator.heightAnchor.constraint(equalToConstant: 1)
			])
	}
}

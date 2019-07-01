//
//  ProfileTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol UserCoinsUpdateDelegate {
	func userCoinsDidUpdate(coinsRow: Int)
}

class ProfileTableViewModel: NSObject {
	
	private typealias ProfileHeaderCellConfigurator = CellsConfigurator<ProfileHeaderCell, (imageURLString: String?, name: String)>
	private typealias ProfileButtonsCellConfigurator = CellsConfigurator<ProfileButtonsCell, Void>
	private typealias BalanceCellConfigurator = CellsConfigurator<BalanceCell, Int>
	private typealias ProgressCellConfigurator = CellsConfigurator<ProgressCell, [UIImage]>
	private typealias UserDataCellConfigurator = CellsConfigurator<UserDataCell, (icon: UIImage, text: String?)>
	private typealias UserButtonArrowConfigurator = CellsConfigurator<UserButtonArrowCell, (icon: UIImage, text: String)>
	
	private var rows: [CellConfigurator] {
		var rows = [CellConfigurator]()
		rows.append(getHeaderRow(from: user))
		rows.append(getProfileButonsRow())
		rows.append(getBalanceRow(from: user))
//		rows.append(getProgressRow())
		rows.append(contentsOf: getUserDataRows(from: user))
		rows.append(contentsOf: getUserButtonArrowRows())
		
		return rows
	}
	private var user: User
	var delegate: UserCoinsUpdateDelegate?
	
	init(user: User) {
		self.user = user
		super.init()
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(handleCoinsAdded(_:)),
											   name: .coinsAdded,
											   object: nil)
	}
	
	private func getHeaderRow(from user: User) -> CellConfigurator {
		return ProfileHeaderCellConfigurator(item: (user.avatar, user.fullName))
	}
	
	private func getProfileButonsRow() -> CellConfigurator {
		return ProfileButtonsCellConfigurator()
	}
	
	private func getBalanceRow(from user: User) -> CellConfigurator {
		return BalanceCellConfigurator(item: user.coins)
	}
	
	private func getProgressRow() -> CellConfigurator {
		return ProgressCellConfigurator(item: [#imageLiteral(resourceName: "progressTest"), #imageLiteral(resourceName: "progressTest")])
	}
	
	private func getUserDataRows(from user: User) -> [CellConfigurator] {
		return [
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "smartphone"), user.phone)),
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "mail"), user.email)),
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "instagram"), user.instagram)),
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "location"), user.location))
		]
	}
	
	private func getUserButtonArrowRows() -> [CellConfigurator] {
		return [
			UserButtonArrowConfigurator(item: (#imageLiteral(resourceName: "coin"), "Coins")),
			UserButtonArrowConfigurator(item: (#imageLiteral(resourceName: "shoppingBag"), "Store")),
			UserButtonArrowConfigurator(item: (#imageLiteral(resourceName: "videoCamera"), "Video library")),
			UserButtonArrowConfigurator(item: (#imageLiteral(resourceName: "info1"), "How to use the application")),
			UserButtonArrowConfigurator(item: (#imageLiteral(resourceName: "faq"), "FAQ"))
		]
	}
	
	func getCellTitleFor(at row: Int) -> String? {
		if let buttonArrowConfigurator = rows[row] as? UserButtonArrowConfigurator {
			return buttonArrowConfigurator.item?.text
		}
		return nil
	}
	
	@objc private func handleCoinsAdded(_ notification: Notification) {
		if let userInfo = notification.userInfo as? [String: Int],
			let value = userInfo["value"] {
			if let oldCoins = user.coins {
				user.coins = oldCoins + value
			} else {
				user.coins = value
			}
			delegate?.userCoinsDidUpdate(coinsRow: 2)
		}
	}
	
}

extension ProfileTableViewModel: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return rows.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = rows[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseId, for: indexPath)
		item.configure(cell: cell)
		
		return cell
	}
}

//
//  ProfileTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ProfileTableViewModel: NSObject {
	
	private typealias ProfileHeaderCellConfigurator = CellsConfigurator<ProfileHeaderCell, (imageURLString: String?, name: String)>
	private typealias ProfileButtonsCellConfigurator = CellsConfigurator<ProfileButtonsCell, Void>
	private typealias BalanceCellConfigurator = CellsConfigurator<BalanceCell, Int>
	private typealias ProgressCellConfigurator = CellsConfigurator<ProgressCell, [UIImage]>
	private typealias UserDataCellConfigurator = CellsConfigurator<UserDataCell, (icon: UIImage, text: String?)>
	private typealias UserButtonArrowConfigurator = CellsConfigurator<UserButtonArrowCell, (icon: UIImage, text: String)>
	
	private var rows: [CellConfigurator]
	
	init(user: User) {
		rows = []
		super.init()
		rows.append(getHeaderRow(from: user))
		rows.append(getProfileButonsRow())
		rows.append(getBalanceRow(from: user))
		rows.append(getProgressRow())
		rows.append(contentsOf: getUserDataRows(from: user))
		rows.append(contentsOf: getUserButtonArrowRows())
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

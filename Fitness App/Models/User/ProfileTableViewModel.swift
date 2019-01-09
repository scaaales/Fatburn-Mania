//
//  ProfileTableViewModel.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

typealias ProfileHeaderCellConfigurator = CellsConfigurator<ProfileHeaderCell, (image: UIImage, name: String)>
typealias ProfileButtonsCellConfigurator = CellsConfigurator<ProfileButtonsCell, Void>
typealias BalanceCellConfigurator = CellsConfigurator<BalanceCell, UInt>
typealias ProgressCellConfigurator = CellsConfigurator<ProgressCell, [UIImage]>
typealias UserDataCellConfigurator = CellsConfigurator<UserDataCell, (icon: UIImage, text: String)>
typealias UserButtonArrowConfigurator = CellsConfigurator<UserButtonArrowCell, (icon: UIImage, text: String)>

class ProfileTableViewModel: NSObject {
	
	private var rows: [CellConfigurator]
	
	init(user: User? = nil) {
		rows = []
		super.init()
		guard let user = user else { return }
		rows.append(getHeaderRow(from: user))
		rows.append(getProfileButonsRow())
		rows.append(getBalanceRow(from: user))
		rows.append(getProgressRow())
		rows.append(contentsOf: getUserDataRows(from: user))
		rows.append(contentsOf: getUserButtonArrowRows())
	}
	
	private func getHeaderRow(from user: User) -> CellConfigurator {
		return ProfileHeaderCellConfigurator(item: (user.avatar, user.name))
	}
	
	private func getProfileButonsRow() -> CellConfigurator {
		return ProfileButtonsCellConfigurator()
	}
	
	private func getBalanceRow(from user: User) -> CellConfigurator {
		return BalanceCellConfigurator(item: user.balance)
	}
	
	private func getProgressRow() -> CellConfigurator {
		return ProgressCellConfigurator(item: [#imageLiteral(resourceName: "progressTest"), #imageLiteral(resourceName: "progressTest")])
	}
	
	private func getUserDataRows(from user: User) -> [CellConfigurator] {
		return [
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "smartphone"), user.phoneNumber)),
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "mail"), user.email)),
			UserDataCellConfigurator(item: (#imageLiteral(resourceName: "instagram"), user.instagramName)),
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

//
//  HowToViewController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {

	private typealias HowToImageCellConfigurator = CellsConfigurator<HowToImageCell, UIImage>
	private typealias HowToTextCellConfigurator = CellsConfigurator<HowToTextCell, String>
	
	@IBOutlet private weak var tableView: UITableView!
	
	private let tableViewContent: [CellConfigurator] = [
		HowToImageCellConfigurator(item: #imageLiteral(resourceName: "tutorialPlaceholder")),
		HowToTextCellConfigurator(item: String.loremIpsumConstant),
		HowToImageCellConfigurator(item: #imageLiteral(resourceName: "tutorialPlaceholder")),
		HowToTextCellConfigurator(item: String.loremIpsumConstant),
		HowToImageCellConfigurator(item: #imageLiteral(resourceName: "tutorialPlaceholder")),
		HowToTextCellConfigurator(item: String.loremIpsumConstant),
		HowToImageCellConfigurator(item: #imageLiteral(resourceName: "tutorialPlaceholder")),
		HowToTextCellConfigurator(item: String.loremIpsumConstant)
	]
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setupTableView()
    }
	
	private func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 1
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.backgroundColor = .white
	}

}

extension HowToViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewContent.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = tableViewContent[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseId, for: indexPath)
		
		item.configure(cell: cell)
		
		return cell
	}
	
	
}

extension HowToViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 20
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}

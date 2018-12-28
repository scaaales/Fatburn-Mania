//
//  ViewController.swift
//  Fitness Test App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let tableViewModel = TableViewModel()

	@IBOutlet private weak var calendarView: CalendarView!
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		calendarView.configure()
		setupTableView()
		setupNavigationBar()
		healthKitTest()
	}
	
	private func healthKitTest() {
		HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
			if !authorized {
				let baseMessage = "HealthKit Authorization Failed"
				if let error = error {
					print("\(baseMessage). Reason: \(error.localizedDescription)")
				} else {
					print(baseMessage)
				}
			}
		}
		
		ProfileDataStore.getTodaySteps { value in
			self.tableViewModel.steps = value
		}
		
		ProfileDataStore.getTodayCalories { value in
			self.tableViewModel.calories = value
		}
		
		ProfileDataStore.getTodayProteins { value in
			self.tableViewModel.proteins = value
		}
		
		ProfileDataStore.getTodayFats { value in
			self.tableViewModel.fats = value
		}
		
		ProfileDataStore.getTodayCarbohydrates { value in
			self.tableViewModel.carbohydrates = value
		}
		
		ProfileDataStore.getTodayWater { value in
			self.tableViewModel.water = value
		}
	}
	
	private func setupNavigationBar() {
		navigationController?.navigationBar.shadowImage = UIImage()
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.estimatedSectionHeaderHeight = 1
		tableView.sectionHeaderHeight = UITableView.automaticDimension
		
		tableView.estimatedRowHeight = 1
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.estimatedSectionFooterHeight = 1
		tableView.sectionFooterHeight = UITableView.automaticDimension
		
		tableView.backgroundColor = .white
	}
}

extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.sections[section].items.count
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let item = tableViewModel.sections[section].header, let header = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId) {
			item.configure(cell: header)
			
			return header.contentView
		}
		
		return nil
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = tableViewModel.sections[indexPath.section].items[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
		item.configure(cell: cell)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		if let item = tableViewModel.sections[section].footer, let footer = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId) {
			item.configure(cell: footer)
			
			return footer.contentView
		}
		
		return nil
	}
	
}

extension ViewController: UITableViewDelegate {
	
}

// MARK: - Scroll view delegate
extension ViewController {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffsetY = scrollView.contentOffset.y
		if contentOffsetY > 10 {
			calendarView.closeAnimated()
		} else {
			calendarView.openAnimated()
		}
	}
}

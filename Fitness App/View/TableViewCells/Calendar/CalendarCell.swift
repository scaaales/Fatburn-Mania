//
//  CalendarCell.swift
//  Fitness Test App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: UITableViewCell, ConfigurableCell {
	@IBOutlet private weak var shadowView: UIView!
	@IBOutlet private weak var roundedView: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var collectionView: JTAppleCalendarView!
	
	private let formatter = DateFormatter()

	func configure() {
		collectionView.calendarDelegate = self
		collectionView.calendarDataSource = self
		collectionView.minimumLineSpacing = 0
		collectionView.minimumInteritemSpacing = 0
		collectionView.visibleDates { [weak self] visibleDate in
			self?.setupViewsOfCalendar(from: visibleDate)
		}
		collectionView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false)
		
		makeRounded(view: roundedView, masksToBounds: true)
		makeRounded(view: shadowView, masksToBounds: false)
		makeShadow()
	}
	
	private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
		guard let date = visibleDates.monthDates.first?.date else { return }
		
		formatter.dateFormat = "MMMM yyyy"
		let monthWithYear = formatter.string(from: date)
		titleLabel.text = monthWithYear
	}
	
	private func makeRounded(view: UIView, masksToBounds: Bool) {
		view.layer.cornerRadius = 30
		view.layer.masksToBounds = masksToBounds
	}
	
	private func makeShadow() {
		shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 30).cgPath
		shadowView.layer.shadowColor = UIColor.black.cgColor
		shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
		shadowView.layer.shadowOpacity = 0.5
		shadowView.layer.shadowRadius = 6
	}
	
	@IBAction func prevMonth(_ sender: Any) {
		 collectionView.scrollToSegment(.previous)
	}
	
	@IBAction func nextMonth(_ sender: Any) {
		 collectionView.scrollToSegment(.next)
	}
	
}

extension CalendarCell: JTAppleCalendarViewDataSource {
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		
		guard let startDate = formatter.date(from: "2017 12 01"), let endDate = formatter.date(from: "2019 12 31") else { fatalError() }
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
		return parameters
	}
	
	
}

extension CalendarCell: JTAppleCalendarViewDelegate {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {

	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarDateCell.reuseId, for: indexPath) as? CalendarDateCell else { fatalError() }
		if cellState.dateBelongsTo == .thisMonth {
			cell.configure(text: cellState.text, isSelected: false, hasIvent: false)
		} else {
			cell.configureEmpty()
		}
		
		return cell
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarDateCell else { return }
		cell.set(selected: true)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		guard let cell = cell as? CalendarDateCell else { return }
		cell.set(selected: false)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
		setupViewsOfCalendar(from: visibleDates)
	}
	
}


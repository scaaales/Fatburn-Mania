//
//  CalendarCell.swift
//  Fitness App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol CalendarViewDateDelegate: class {
	func didSelectDate(_ date: Date)
}

class CalendarView: UIView {
	
	@IBOutlet private weak var shadowView: UIView!
	@IBOutlet private weak var roundedView: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var collectionView: JTAppleCalendarView!
	
	@IBOutlet private weak var collectionViewTopOffset: NSLayoutConstraint!
	@IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
	@IBOutlet private weak var collectionViewBottom: NSLayoutConstraint!
	
	private let formatter = DateFormatter()
	
	private var delegate: CalendarViewDateDelegate?
	private var isClosed = false
	private var selectedDateRow = 1
	private var prevSelectedDate = Date()
	
	func configure(calendarViewDateDelegate: CalendarViewDateDelegate?) {
		delegate = calendarViewDateDelegate
		setupCollectionView()
		makeRounded(view: roundedView, masksToBounds: true)
		makeRounded(view: shadowView, masksToBounds: false)
		makeShadow()
	}
	
	private func setupCollectionView() {
		collectionView.calendarDelegate = self
		collectionView.calendarDataSource = self
		collectionView.minimumLineSpacing = 0
		collectionView.minimumInteritemSpacing = 0
		collectionView.visibleDates { [weak self] visibleDate in
			self?.setupViewsOfCalendar(from: visibleDate)
		}
		collectionView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false) { [weak self] in
			self?.collectionView.selectDates([Date()])
		}
		collectionView.clipsToBounds = false
	}
	
	private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
		guard let date = visibleDates.monthDates.first?.date else { return }
		
		formatter.dateFormat = "MMMM yyyy"
		let monthWithYear = formatter.string(from: date)
		self.titleLabel.text = monthWithYear
	}
	
	func closeAnimated() {
		collectionViewHeight.constant = collectionView.visibleCells.first!.bounds.height + 20
		
		collectionViewBottom.isActive = false
		collectionViewHeight.isActive = true
		
		var newCollectionViewYoffset: CGFloat?
		
		if let selectedDate = collectionView.selectedDates.first,
			let selectedCellRow = collectionView.cellStatus(for: selectedDate)?.row(),
			let cellHeight = collectionView.visibleCells.first?.bounds.height {
			newCollectionViewYoffset = (cellHeight)*CGFloat(selectedCellRow)
		}
		
		if let newOriginY = newCollectionViewYoffset {
			collectionViewTopOffset.constant = -newOriginY
		}
		
		isClosed = true
		UIView.animate(withDuration: 0.2) {
			self.superview?.layoutIfNeeded()
		}
	}
	
	func openAnimated() {
		collectionViewHeight.isActive = false
		collectionViewBottom.isActive = true

		collectionViewTopOffset.constant = 0
		isClosed = false
		UIView.animate(withDuration: 0.2) {
			self.superview?.layoutIfNeeded()
		}
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

extension CalendarView: JTAppleCalendarViewDataSource {
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		let startDate = Date(day: 01, month: 12, year: 2017)
		let endDate = Date(day: 31, month: 12, year: 2019)
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
		return parameters
	}
	
	
}

extension CalendarView: JTAppleCalendarViewDelegate {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarDateCell.reuseId, for: indexPath) as? CalendarDateCell else { fatalError() }
		if cellState.dateBelongsTo == .thisMonth {
			cell.configure(text: cellState.text, isSelected: cellState.isSelected, hasIvent: false)
		} else {
			cell.configureEmpty()
		}
		
		return cell
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		if isClosed && cellState.row() != selectedDateRow {
			calendar.selectDates([prevSelectedDate])
			return
		}
		guard let cell = cell as? CalendarDateCell else { return }
		cell.set(selected: true)
		if date != prevSelectedDate {
			delegate?.didSelectDate(date)
		}
		selectedDateRow = cellState.row()
		prevSelectedDate = date
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		
		guard let cell = cell as? CalendarDateCell else { return }
		cell.set(selected: false)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
		setupViewsOfCalendar(from: visibleDates)
	}
	
}


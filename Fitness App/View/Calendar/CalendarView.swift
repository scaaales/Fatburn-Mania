//
//  CalendarCell.swift
//  Fitness Test App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarView: UIView {
	enum State {
		case open
		case closed
		case animating
	}
	
	@IBOutlet private weak var shadowView: UIView!
	@IBOutlet private weak var roundedView: UIView!
	@IBOutlet private weak var titleButton: UIButton!
	@IBOutlet private weak var collectionView: JTAppleCalendarView!
	
	@IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
	@IBOutlet private weak var collectionViewBottom: NSLayoutConstraint!
	
	private let formatter = DateFormatter()

	private(set) var state = State.open {
		didSet {
			if state == .animating {
				collectionView.isScrollEnabled = false
			} else {
				collectionView.isScrollEnabled = true
			}
		}
	}
	
	func configure() {
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
		UIView.performWithoutAnimation {
			self.titleButton.setTitle(monthWithYear, for: .normal)
			self.titleButton.layoutIfNeeded()
			
		}
	}
	
	func closeAnimated() {
		collectionViewHeight.constant = collectionView.visibleCells.first!.bounds.height + 20
		
		collectionViewBottom.isActive = false
		collectionViewHeight.isActive = true
		
		state = .animating
		
		UIView.animate(withDuration: 1, animations: {
			self.superview?.layoutIfNeeded()
		}) { _ in
			self.state = .closed
		}
	}
	
	func openAnimated() {
		collectionViewHeight.isActive = false
		collectionViewBottom.isActive = true
		
		state = .animating
		collectionView.isScrollEnabled = false
		
		UIView.animate(withDuration: 1, animations: {
			self.superview?.layoutIfNeeded()
		}) { _ in
			self.state = .open
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
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		
		guard let startDate = formatter.date(from: "2017 12 01"), let endDate = formatter.date(from: "2019 12 31") else { fatalError() }
		
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


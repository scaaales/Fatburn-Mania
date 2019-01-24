//
//  LessonViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import WebKit

class LessonViewController: UIViewController {
	var presenter: LessonPresenter<LessonViewController>!
	
	@IBOutlet private weak var lessonNameLabel: UILabel!
	@IBOutlet private weak var webViewContainer: UIView!
	private var webView: WKWebView!
	@IBOutlet private weak var lessonDescriptionLabel: UILabel!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupWebView()
		tableView.delegate = self
		presenter.getLesson()
	}
	
	override func viewDidLayoutSubviews() {
		tableViewHeight.constant = tableView.contentSize.height
	}
	
	private func setupWebView() {
		let webConfiguration = WKWebViewConfiguration()
		webConfiguration.allowsInlineMediaPlayback = true
		
		webView = .init(frame: webViewContainer.frame, configuration: webConfiguration)
		webView.scrollView.isScrollEnabled = false
		
		webViewContainer.makeCornerRadius(15)
		webViewContainer.addSubview(webView)
		webView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			webView.leadingAnchor.constraint(equalTo: webViewContainer.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: webViewContainer.trailingAnchor),
			webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor),
			webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor)
			])
	}
	
}

extension LessonViewController: LessonView {
	func setTitle(_ title: String) {
		self.title = title
	}
	
	func setLessonName(_ name: String) {
		lessonNameLabel.text = name
	}
	
	func setDescription(_ text: String) {
		lessonDescriptionLabel.text = text
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func loadVideoRequest(_ urlRequest: URLRequest) {
		webView.load(urlRequest)
	}
	
}

extension LessonViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}

}



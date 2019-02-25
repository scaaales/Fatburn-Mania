//
//  FAQViewController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

	@IBOutlet private weak var textView: UITextView!
	private var faqApi: FitnessApi.FAQ!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		textView.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
		textView.isScrollEnabled = false
		textView.text = ""
		
		faqApi = .init()
		faqApi.getFaqHtmlString(onComplete: {
			
		}, onSuccess: { [weak self] faqHtmlString in
			self?.updateTextView(with: faqHtmlString)
		}) { errorText in
			print(errorText)
		}
    }
	
	private func updateTextView(with newString: String) {
		DispatchQueue.main.async {
			let attrStr = try! NSAttributedString(
				data: (newString.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
				options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
				documentAttributes: nil)
			
			self.textView.attributedText = attrStr
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		textView.isScrollEnabled = true
	}

}

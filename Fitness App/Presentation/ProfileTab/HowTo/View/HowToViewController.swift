//
//  HowToViewController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {

	@IBOutlet private weak var textView: UITextView!
	private var faqApi: FitnessApi.FAQ!
	private var attributedText: NSMutableAttributedString?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textView.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
		textView.isScrollEnabled = false
		textView.text = ""
		
		faqApi = .init()
		faqApi.getHowToHtmlString(onComplete: {
			
		}, onSuccess: { [weak self] howToHtmlString in
			self?.updateTextView(with: howToHtmlString)
		}) { errorText in
			print(errorText)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		prepareTextImages()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		textView.isScrollEnabled = true
	}
	
	private func updateTextView(with newString: String) {
		DispatchQueue.main.async {
			self.attributedText = try! NSMutableAttributedString(
				data: (newString.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
				options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
				documentAttributes: nil)
			
			self.textView.attributedText = self.attributedText
			self.textView.textAlignment = .justified
			self.textView.contentMode = .scaleToFill
		}
	}
	
	private func prepareTextImages() {
		guard let text = self.attributedText else { return }
		let width = self.view.frame.width - 40
		
		text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: text.length), options: [], using: { [width] (object, range, pointer) in
			if let attachment = object as? NSTextAttachment, let img = attachment.image(forBounds: self.textView.bounds, textContainer: nil, characterIndex: range.location) {
				if attachment.fileType == "public.png" ||
					attachment.fileType == "public.jpeg" ||
					attachment.fileType == "public.image" {
					let aspect = img.size.width / img.size.height
					if img.size.width <= width {
						attachment.bounds = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
						return
					}
					let height = width / aspect
					attachment.bounds = CGRect(x: 0, y: 0, width: width, height: height)
				}
			}
		})
	}


}

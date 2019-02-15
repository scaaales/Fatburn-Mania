//
//  ProductDetailViewController.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
	var presenter: ProductDetailPresenter<ProductDetailViewController>!
	
	@IBOutlet private weak var productImageView: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var priceLabel: UILabel!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.getProduct()
		setupImageView()
	}
	
	private func setupImageView() {
		let path = UIBezierPath(roundedRect: productImageView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 30, height: 30))
		let newMaskLayer = CAShapeLayer()
		newMaskLayer.path = path.cgPath
		productImageView.layer.mask = newMaskLayer
	}
	
	@IBAction private func buyTapped(_ sender: Any) {
		presenter.buyProduct()
	}
	
}

extension ProductDetailViewController: ProductDetailView {
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}
	
	func showProduct(_ product: Product) {
		productImageView.setImageFrom(urlString: product.photoUrlString)
		titleLabel.text = product.title
		descriptionLabel.text = product.description
		priceLabel.text = "\(product.price.formattedWithSeparator) c."
	}
	
	func showConfirmPopup(with text: String, okHandler: @escaping () -> Void) {
		let alertController = UIAlertController(title: "Confirm purchase", message: text, preferredStyle: .alert)
		alertController.addAction(.init(title: "Yes", style: .default, handler: { _ in
			okHandler()
		}))
		alertController.addAction(.init(title: "No", style: .cancel))
		present(alertController, animated: true)
	}
}



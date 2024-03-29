//
//  AddNewMeasurementsViewController.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class AddNewMeasurementsViewController: UIViewController {
	var presenter: AddNewMeasurementsPresenter<AddNewMeasurementsViewController>!
	
	@IBOutlet private weak var dateLabel: UILabel!
	@IBOutlet private weak var chestTextField: UITextField!
	@IBOutlet private weak var waistTextField: UITextField!
	@IBOutlet private weak var thighsTextField: UITextField!
	@IBOutlet private weak var hipTextField: UITextField!
	@IBOutlet private weak var weightTextField: UITextField!
	
	private var textFieldAssistant: TextFieldAssistant!
	var diaryViewController: DiaryViewController!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textFieldAssistant = .init(view: view,
								   firstResponderTag: 100,
								   lastResponderTag: 104,
								   handleTextFieldDelegate: true)
		hideKeyboardWhenTappedAround()
		presenter.getDefaultMeasurements()
		presenter.getDate()
		setupTextFields()
	}
	
	private func setupTextFields() {
		[chestTextField, waistTextField, thighsTextField, hipTextField, weightTextField].forEach {
			$0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		}
	}
	
	@objc private func textFieldDidChange(_ textField: UITextField) {
		guard let text = textField.text else { return }
		
		if textField === weightTextField {
			if text.count > 6 {
				textField.text = String(text.prefix(6))
			}
		} else {
			if text.count > 3 {
				textField.text = String(text.prefix(3))
			}
		}
	}
	
	@IBAction private func addTapped() {
		presenter.addNewMeasurements()
	}
	
	@IBAction func closeItself() {
		dismiss(animated: true) { [weak self] in
			guard let self = self else { return }
			if let newMeasurements = self.presenter.addedMeasurements {
				self.diaryViewController.presenter.todayMeasurementsChanged()
				self.diaryViewController.presenter.updateCurrentDay(with: newMeasurements)
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let coinsAddedVC = segue.destination as? CoinsAddedViewController,
			let coinsAmount = sender as? Int {
			coinsAddedVC.coinsAmount = coinsAmount
			coinsAddedVC.prevVC = self
		}
	}
	
}

extension AddNewMeasurementsViewController: AddNewMeasurementsView {
	var chest: String {
		return chestTextField.text ?? ""
	}
	
	var waist: String {
		return waistTextField.text ?? ""
	}
	
	var thighs: String {
		return thighsTextField.text ?? ""
	}
	
	var hip: String {
		return hipTextField.text ?? ""
	}
	
	var weight: String {
		return weightTextField.text ?? ""
	}
	
	func setDate(_ date: Date) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
		
		dateLabel.text = dateFormatter.string(from: date)
	}
	
	func setDefaultMeasurements(_ measurements: Measurements) {
		chestTextField.text = "\(measurements.chest)"
		waistTextField.text = "\(measurements.waist)"
		thighsTextField.text = "\(measurements.thighs)"
		hipTextField.text = "\(measurements.hip)"
		weightTextField.text = "\(measurements.weight)"
		
		chestTextField.clearsOnBeginEditing = false
		waistTextField.clearsOnBeginEditing = false
		thighsTextField.clearsOnBeginEditing = false
		hipTextField.clearsOnBeginEditing = false
		weightTextField.clearsOnBeginEditing = false
	}
	
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
	
	func showCoinsAddedScreen(with coinsNumber: Int) {
		performSegue(withIdentifier: .presentCoinsAddedSegueIdentifier, sender: coinsNumber)
	}
	
}



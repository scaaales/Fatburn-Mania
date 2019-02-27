//
//  DiaryTableViewModel.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit


class DiaryTableViewModel: NSObject {
	
	private typealias PlaceholderCellConfigurator = CellsConfigurator<PlaceholderCell, Void>
	
	private typealias DefaultSectionHeaderConfigurator = CellsConfigurator<DefaultSectionHeader, String>
	private typealias TrainingDayCellConfigurator = CellsConfigurator<TrainingDayCell, TrainingDay>
	
	private typealias StepCellConfigurator = CellsConfigurator<StepCell, Steps>
	
	private typealias WaterCellConfigurator = CellsConfigurator<WaterCell, Measurement>
	
	private typealias NutritionCellConfigurator = CellsConfigurator<NutritionCell, Measurement>
	
	private typealias BodyMeasurementHeaderConfigurator = CellsConfigurator<BodyMeasurementHeader, MeasurementPeriod>
	private typealias BodyMeasurementCellConfigurator = CellsConfigurator<BodyMeasurementCell, Measurement>
	private typealias BodyMeasurementFooterConfigurator = CellsConfigurator<BodyMeasurementFooter, Void>
	
	struct Section {
		let items: [CellConfigurator]
	}
	
	var trainingDay: TrainingDay?
	var steps: Steps?
	var water: Measurement?
	var calories: Measurement?
	var proteins: Measurement?
	var fats: Measurement?
	var carbohydrates: Measurement?
	var leftBodyMeasurements: Measurements?
	var rightBodyMeasurements: Measurements?
	var leftDateString: String?
	var rightDateString: String
	
	private var sections: [Section] {
		let trainingDaySection = getTrainingDaySection()
		let stepsSection = getStepsSection()
		let waterSection = getWaterSection()
		let nutritionSection = getNutritionSection()
		let bodyMeasurementsSection = getBodyMeasurementsSection()
		
		return [trainingDaySection, stepsSection, waterSection, nutritionSection, bodyMeasurementsSection]
	}
	
	init(leftBodyMeasurements: Measurements?,
		 rightBodyMeasurements: Measurements?,
		 leftDateString: String,
		 rightDateString: String) {
		self.leftBodyMeasurements = leftBodyMeasurements
		self.rightBodyMeasurements = rightBodyMeasurements
		self.leftDateString = leftDateString
		self.rightDateString = rightDateString
	}
	
	private func getTrainingDaySection() -> Section {
		let trainingDay = self.trainingDay ?? .init()
		
		let result = Section(items: [
			PlaceholderCellConfigurator(),
			DefaultSectionHeaderConfigurator(item: "Training day"),
			TrainingDayCellConfigurator(item: trainingDay)])
		
		return result
	}
	
	private func getStepsSection() -> Section {
		let steps = self.steps ?? Steps(current: 0, goal: 8000)
		
		let result = Section( items: [
			DefaultSectionHeaderConfigurator(item: "Steps"),
			StepCellConfigurator(item: steps)])
		
		return result
	}
	
	private func getWaterSection() -> Section {
		let water = self.water ?? Measurement(name: "",
											  firstValue: 0,
											  secondValue: 2,
											  unit: "pt")
		
		let result = Section(items: [
			DefaultSectionHeaderConfigurator(item: "Water"),
			WaterCellConfigurator(item: water)])
		
		return result
	}
	
	private func getNutritionSection() -> Section {
		let calories = self.calories ?? Measurement(name: "Calories",
													firstValue: 0,
													secondValue: 1980,
													unit: "kcal")
		
		let proteins = self.proteins ?? Measurement(name: "Proteins",
													firstValue: 0,
													secondValue: 148,
													unit: "oz")
		
		let fats = self.fats ?? Measurement(name: "Fats",
											firstValue: 0,
											secondValue: 44,
											unit: "oz")
		
		let carbohydrates = self.carbohydrates ?? Measurement(name: "Carbohydrates",
															  firstValue: 0,
															  secondValue: 247,
															  unit: "oz")
		
		let result = Section(items: [
			DefaultSectionHeaderConfigurator(item: "Nutrition"),
			NutritionCellConfigurator(item: calories),
			NutritionCellConfigurator(item: proteins),
			NutritionCellConfigurator(item: fats),
			NutritionCellConfigurator(item: carbohydrates)
			])
		
		return result
	}
	
	private func getBodyMeasurementsSection() -> Section {
		let result = Section(items: [
			
			BodyMeasurementHeaderConfigurator(item: MeasurementPeriod(startDate: leftDateString ?? rightDateString,
																	  endDate: rightDateString)),
			BodyMeasurementCellConfigurator(item: Measurement(name: "Chest",
															  firstValue: leftBodyMeasurements?.chest.doubleValue,
															  secondValue: rightBodyMeasurements?.chest.doubleValue,
															  unit: "in")),
			BodyMeasurementCellConfigurator(item: Measurement(name: "Waist",
															  firstValue: leftBodyMeasurements?.waist.doubleValue,
															  secondValue: rightBodyMeasurements?.waist.doubleValue,
															  unit: "in")),
			BodyMeasurementCellConfigurator(item: Measurement(name: "Thighs",
															  firstValue: leftBodyMeasurements?.thighs.doubleValue,
															  secondValue: rightBodyMeasurements?.thighs.doubleValue,
															  unit: "in")),
			BodyMeasurementCellConfigurator(item: Measurement(name: "Hip",
															  firstValue: leftBodyMeasurements?.hip.doubleValue,
															  secondValue: rightBodyMeasurements?.hip.doubleValue,
															  unit: "in")),
			BodyMeasurementCellConfigurator(item: Measurement(name: "Weight",
															  firstValue: leftBodyMeasurements?.weight,
															  secondValue: rightBodyMeasurements?.weight,
															  unit: "lb")),
			BodyMeasurementFooterConfigurator()
			])
		
		return result
	}
	
}

extension DiaryTableViewModel: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].items.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = sections[indexPath.section].items[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseId, for: indexPath)
		item.configure(cell: cell)
		
		return cell
	}
	
}


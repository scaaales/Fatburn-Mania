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
	
	class Section {
		let header: CellConfigurator?
		let items: [CellConfigurator]
		let footer: CellConfigurator?
		
		init(header: CellConfigurator?, items: [CellConfigurator], footer: CellConfigurator?) {
			self.header = header
			self.items = items
			self.footer = footer
		}
	}
	
	var trainingDay: TrainingDay?
	var steps: Steps?
	var water: Measurement?
	var calories: Measurement?
	var proteins: Measurement?
	var fats: Measurement?
	var carbohydrates: Measurement?
	
	private var sections: [Section] {
		let placeholderSection = getPlaceholderSection()
		let trainingDaySection = getTrainingDaySection()
		let stepsSection = getStepsSection()
		let waterSection = getWaterSection()
		let nutritionSection = getNutritionSection()
		let bodyMeasurementsSection = getBodyMeasurementsSection()
		
		return [placeholderSection, trainingDaySection, stepsSection, waterSection, nutritionSection, bodyMeasurementsSection]
	}
	
	init(trainingDay: TrainingDay? = nil,
		 steps: Steps? = nil,
		 water: Measurement? = nil,
		 calories: Measurement? = nil,
		 proteins: Measurement? = nil,
		 fats: Measurement? = nil,
		 carbohydrates: Measurement? = nil) {
		self.trainingDay = trainingDay
		self.steps = steps
		self.water = water
		self.calories = calories
		self.proteins = proteins
		self.fats = fats
		self.carbohydrates = carbohydrates
	}
	
	private func getPlaceholderSection() -> Section {
		let result = Section(header: nil,
							 items: [PlaceholderCellConfigurator()],
							 footer: nil)
		return result
	}
	
	private func getTrainingDaySection() -> Section {
		let trainingDay = self.trainingDay ?? TrainingDay(time: "-- --",
														  calories: "-- --",
														  coins: "-- --")
		
		let result = Section(header: DefaultSectionHeaderConfigurator(item: "Training day"),
							 items: [TrainingDayCellConfigurator(item: trainingDay)],
							 footer: nil)
		
		return result
	}
	
	private func getStepsSection() -> Section {
		let steps = self.steps ?? Steps(current: 0, goal: 8000)
		
		let result = Section(header: DefaultSectionHeaderConfigurator(item: "Steps"),
							 items: [StepCellConfigurator(item: steps)],
							 footer: nil)
		
		return result
	}
	
	private func getWaterSection() -> Section {
		let water = self.water ?? Measurement(name: "",
											  firstValue: 0,
											  secondValue: 2,
											  unit: "pt")
		
		let result = Section(header: DefaultSectionHeaderConfigurator(item: "Water"),
							 items: [WaterCellConfigurator(item: water)],
							 footer: nil)
		
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
		
		let result = Section(header: DefaultSectionHeaderConfigurator(item: "Nutrition"),
				items: [
					NutritionCellConfigurator(item: calories),
					NutritionCellConfigurator(item: proteins),
					NutritionCellConfigurator(item: fats),
					NutritionCellConfigurator(item: carbohydrates)
			],
				footer: nil)
		
		return result
	}
	
	private func getBodyMeasurementsSection() -> Section {
		let result = Section(header: BodyMeasurementHeaderConfigurator(item: MeasurementPeriod(startDate: "12.10.2018 17:35", endDate: Date.todayWithCurrentTime)),
							 items: [
								BodyMeasurementCellConfigurator(item: Measurement(name: "Chest",
																				  firstValue: 100,
																				  secondValue: nil,
																				  unit: "см")),
								BodyMeasurementCellConfigurator(item: Measurement(name: "Waist",
																				  firstValue: 60,
																				  secondValue: nil,
																				  unit: "см")),
								BodyMeasurementCellConfigurator(item: Measurement(name: "Thighs",
																				  firstValue: 90,
																				  secondValue: nil,
																				  unit: "см")),
								BodyMeasurementCellConfigurator(item: Measurement(name: "Hip",
																				  firstValue: 25,
																				  secondValue: nil,
																				  unit: "см")),
								BodyMeasurementCellConfigurator(item: Measurement(name: "Weight",
																				  firstValue: 60,
																				  secondValue: nil,
																				  unit: "кг"))
			],
							 footer: BodyMeasurementFooterConfigurator())
		
		return result
	}
	
	func headerFor(index: Int) -> CellConfigurator? {
		return sections[index].header
	}
	
	func footerFor(index: Int) -> CellConfigurator? {
		return sections[index].footer
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


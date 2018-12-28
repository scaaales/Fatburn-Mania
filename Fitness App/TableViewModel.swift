//
//  TableViewModel.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

typealias DefaultSectionHeaderConfigurator = TableCellConfigurator<DefaultSectionHeader, String>
typealias TrainingDayCellConfigurator = TableCellConfigurator<TrainingDayCell, TrainingDay>

typealias StepCellConfigurator = TableCellConfigurator<StepCell, Steps>

typealias WaterCellConfigurator = TableCellConfigurator<WaterCell, Measurement>

typealias NutritionCellConfigurator = TableCellConfigurator<NutritionCell, Measurement>

typealias BodyMeasurementHeaderConfigurator = TableCellConfigurator<BodyMeasurementHeader, MeasurementPeriod>
typealias BodyMeasurementCellConfigurator = TableCellConfigurator<BodyMeasurementCell, Measurement>
typealias BodyMeasurementFooterConfigurator = TableCellConfigurator<BodyMeasurementFooter, Void>


class TableViewModel {
	
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
	
	var sections: [Section] {
		let trainingDaySection = getTrainingDaySection()
		let stepsSection = getStepsSection()
		let waterSection = getWaterSection()
		let nutritionSection = getNutritionSection()
		let bodyMeasurementsSection = getBodyMeasurementsSection()
		
		return [trainingDaySection, stepsSection, waterSection, nutritionSection, bodyMeasurementsSection]
	}
	
	private func getTrainingDaySection() -> Section {
		let trainingDay = self.trainingDay ?? TrainingDay(time: "02 36",
														  calories: "-- --",
														  coins: "-- --")
		
		let result = Section(header: DefaultSectionHeaderConfigurator(item: "Training day"),
							 items: [TrainingDayCellConfigurator(item: trainingDay)],
							 footer: nil)
		
		return result
	}
	
	private func getStepsSection() -> Section {
		let steps = self.steps ?? Steps(current: 2672, goal: 8000)
		
		let result = Section(header: DefaultSectionHeaderConfigurator(item: "Steps"),
							 items: [StepCellConfigurator(item: steps)],
							 footer: nil)
		
		return result
	}
	
	private func getWaterSection() -> Section {
		let water = self.water ?? Measurement(name: "",
											  firstValue: 500,
											  secondValue: 2000,
											  unit: "ml")
		
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

}

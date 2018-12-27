//
//  TableViewModel.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

typealias CalendarCellConfigurator = TableCellConfigurator<CalendarCell, Void>

typealias DefaultSectionHeaderConfigurator = TableCellConfigurator<DefaultSectionHeader, String>
typealias TrainingDayCellConfigurator = TableCellConfigurator<TrainingDayCell, TrainingDay>

typealias StepCellConfigurator = TableCellConfigurator<StepCell, Steps>

typealias WaterCellConfigurator = TableCellConfigurator<WaterCell, Water>

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
	
	var sections: [Section] {
		let calendarSection = Section(header: nil,
								   items: [CalendarCellConfigurator()],
								   footer: nil)
		
		let trainingDaySection = Section(header: DefaultSectionHeaderConfigurator(item: "Training day"),
									items: [TrainingDayCellConfigurator(item: TrainingDay(time: "02 36",
																						  calories: "-- --",
																						  coins: "-- --"))],
									footer: nil)
		
		let stepsSection = Section(header: DefaultSectionHeaderConfigurator(item: "Steps"),
								   items: [StepCellConfigurator(item: Steps(current: 2672,
																			goal: 5000))],
								   footer: nil)
		
		let waterSection = Section(header: DefaultSectionHeaderConfigurator(item: "Water"),
									items: [WaterCellConfigurator(item: Water(result: "0",
																			  goal: "2 pt"))],
									footer: nil)
		
		let nutritionSection = Section(header: DefaultSectionHeaderConfigurator(item: "Nutrition"),
									   items: [
										NutritionCellConfigurator(item: Measurement(name: "Calories",
																					firstValue: 0,
																					secondValue: 1980,
																					unit: "kcal")),
										NutritionCellConfigurator(item: Measurement(name: "Proteins",
																					firstValue: 0,
																					secondValue: 148,
																					unit: "oz")),
										NutritionCellConfigurator(item: Measurement(name: "Fats",
																					firstValue: 0,
																					secondValue: 44,
																					unit: "oz")),
										NutritionCellConfigurator(item: Measurement(name: "Carbohydrates",
																					firstValue: 0,
																					secondValue: 247,
																					unit: "oz"))
			],
									   footer: nil)
		
		let bodyMeasurementsSection = Section(header: BodyMeasurementHeaderConfigurator(item: MeasurementPeriod(startDate: "12.10.2018 17:35", endDate: "18.10.2018 17:35")),
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
		
		return [calendarSection, trainingDaySection, stepsSection, waterSection, nutritionSection, bodyMeasurementsSection]
	}

}

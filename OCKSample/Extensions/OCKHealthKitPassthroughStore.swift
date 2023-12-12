//
//  OCKHealthKitPassthroughStore.swift
//  OCKSample
//
//  Created by Corey Baker on 1/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
import HealthKit
import os.log

extension OCKHealthKitPassthroughStore {
    func addTasksIfNotPresent(_ tasks: [OCKHealthKitTask]) async throws {
        let tasksToAdd = tasks
        let taskIdsToAdd = tasksToAdd.compactMap { $0.id }

        // Prepare query to see if tasks are already added
        var query = OCKTaskQuery(for: Date())
        query.ids = taskIdsToAdd

        let foundTasks = try await fetchTasks(query: query)
        var tasksNotInStore = [OCKHealthKitTask]()

        // Check results to see if there's a missing task
        tasksToAdd.forEach { potentialTask in
            if foundTasks.first(where: { $0.id == potentialTask.id }) == nil {
                tasksNotInStore.append(potentialTask)
            }
        }

        // Only add if there's a new task
        if tasksNotInStore.count > 0 {
            do {
                _ = try await addTasks(tasksNotInStore)
                Logger.ockHealthKitPassthroughStore.info("Added tasks into HealthKitPassthroughStore!")
            } catch {
                Logger.ockHealthKitPassthroughStore.error("Error adding HealthKitTasks: \(error)")
            }
        }
    }

        func populateSampleData(_ patientUUID: UUID? = nil) async throws {

        let dailySchedule = OCKSchedule.dailyAtTime(hour: 12, minutes: 00, start: Date(), end: nil, text: nil)
        let moveSchedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(12), targetValues: [OCKOutcomeValue(30, units: "Minutes")])
        let schedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(12), targetValues: [OCKOutcomeValue(2000.0, units: "Steps")])

            let alchoolSchedule = OCKSchedule.weeklyAtTime(weekday: 7,
                                                           hours: 18,
                                                           minutes: 00,
                                                           start: Date(),
                                                           end: nil,
                                                           targetValues: [OCKOutcomeValue(7, units: "Bottles")],
                                                           text: nil)
        let carePlanUUIDs = try await OCKStore.getCarePlanUUIDs() // type method

        var steps = OCKHealthKitTask(
            id: TaskID.steps,
            title: "Steps",
            carePlanUUID: carePlanUUIDs[.steps],
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .stepCount,
                quantityType: .cumulative,
                unit: .count()))
        steps.asset = "figure.walk"
        steps.card = .numericProgress

        var numberOfAlcoholicBeverages = OCKHealthKitTask(id: TaskID.alchoolIntake,
                                                              title: "Alchool Intake",
                                                          carePlanUUID: carePlanUUIDs[.alchool],
                                                          schedule: alchoolSchedule,
                                                          healthKitLinkage: OCKHealthKitLinkage(
                                                            quantityIdentifier: .numberOfAlcoholicBeverages,
                                                            quantityType: .cumulative,
                                                            unit: .count()))
        numberOfAlcoholicBeverages.asset = "wineglass"
        numberOfAlcoholicBeverages.card = .numericProgress
        numberOfAlcoholicBeverages.instructions = "Aim for 7 bottles steps each week!"

            var moveTime = OCKHealthKitTask(id: TaskID.moveTime,
                                              title: "Excercise Time",
                                          carePlanUUID: carePlanUUIDs[.moveTime],
                                          schedule: moveSchedule,
                                          healthKitLinkage: OCKHealthKitLinkage(
                                            quantityIdentifier: .appleMoveTime,
                                            quantityType: .cumulative,
                                            unit: .minute()))

            moveTime.card = .numericProgress
            moveTime.graph = .bar
            moveTime.groupIdentifier = "Move Time" // unit for data series legend
            moveTime.instructions = "30 mins of excersise is recommended!"
            moveTime.asset = "figure.walk.motion"

        var standTime = OCKHealthKitTask(id: TaskID.standingTime,
                                          title: "Stand Time",
                                      carePlanUUID: carePlanUUIDs[.standingTime],
                                      schedule: dailySchedule,
                                      healthKitLinkage: OCKHealthKitLinkage(
                                        quantityIdentifier: .appleMoveTime,
                                        quantityType: .cumulative,
                                        unit: .minute()))

            standTime.asset = "figure.stand"
            standTime.card = .numericProgress
            standTime.instructions = "Aim for at least 10 hours of standing time daily"

    try await addTasksIfNotPresent([steps, standTime, numberOfAlcoholicBeverages, moveTime])

    }
}

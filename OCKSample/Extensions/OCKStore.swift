//
//  OCKStore.swift
//  OCKSample
//
//  Created by Corey Baker on 1/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
import Contacts
import os.log
import ParseSwift
import ParseCareKit

extension OCKStore {

    @MainActor
        class func getCarePlanUUIDs() async throws -> [CarePlanID: UUID] {
            var results = [CarePlanID: UUID]()

            guard let store = AppDelegateKey.defaultValue?.store else {
                return results
            }

            var query = OCKCarePlanQuery(for: Date())
            query.ids = [CarePlanID.health.rawValue,
                         CarePlanID.checkIn.rawValue]

            let foundCarePlans = try await store.fetchCarePlans(query: query)
            // Populate the dictionary for all CarePlan's
            CarePlanID.allCases.forEach { carePlanID in
                results[carePlanID] = foundCarePlans
                    .first(where: { $0.id == carePlanID.rawValue })?.uuid
            }
            return results
        }

    /**
     Adds an `OCKAnyCarePlan`*asynchronously*  to `OCKStore` if it has not been added already.

     - parameter carePlans: The array of `OCKAnyCarePlan`'s to be added to the `OCKStore`.
     - parameter patientUUID: The uuid of the `OCKPatient` to tie to the `OCKCarePlan`. Defaults to nil.
     - throws: An error if there was a problem adding the missing `OCKAnyCarePlan`'s.
     - note: `OCKAnyCarePlan`'s that have an existing `id` will not be added and will not cause errors to be thrown.
    */
    func addCarePlansIfNotPresent(_ carePlans: [OCKAnyCarePlan], patientUUID: UUID? = nil) async throws {
        let carePlanIdsToAdd = carePlans.compactMap { $0.id }

        // Prepare query to see if Care Plan are already added
        var query = OCKCarePlanQuery(for: Date())
        query.ids = carePlanIdsToAdd
        let foundCarePlans = try await self.fetchAnyCarePlans(query: query)
        var carePlanNotInStore = [OCKAnyCarePlan]()
        // Check results to see if there's a missing Care Plan
        carePlans.forEach { potentialCarePlan in
            if foundCarePlans.first(where: { $0.id == potentialCarePlan.id }) == nil {
                // Check if can be casted to OCKCarePlan to add patientUUID
                guard var mutableCarePlan = potentialCarePlan as? OCKCarePlan else {
                    carePlanNotInStore.append(potentialCarePlan)
                    return
                }
                mutableCarePlan.patientUUID = patientUUID
                carePlanNotInStore.append(mutableCarePlan)
            }
        }

        // Only add if there's a new Care Plan
        if carePlanNotInStore.count > 0 {
            do {
                _ = try await self.addAnyCarePlans(carePlanNotInStore)
                Logger.ockStore.info("Added Care Plans into OCKStore!")
            } catch {
                Logger.ockStore.error("Error adding Care Plans: \(error.localizedDescription)")
            }
        }
    }

    func addTasksIfNotPresent(_ tasks: [OCKTask]) async throws {
        let taskIdsToAdd = tasks.compactMap { $0.id }

        // Prepare query to see if tasks are already added
        var query = OCKTaskQuery(for: Date())
        query.ids = taskIdsToAdd

        let foundTasks = try await fetchTasks(query: query)
        var tasksNotInStore = [OCKTask]()

        // Check results to see if there's a missing task
        tasks.forEach { potentialTask in
            if foundTasks.first(where: { $0.id == potentialTask.id }) == nil {
                tasksNotInStore.append(potentialTask)
            }
        }

        // Only add if there's a new task
        if tasksNotInStore.count > 0 {
            do {
                _ = try await addTasks(tasksNotInStore)
                Logger.ockStore.info("Added tasks into OCKStore!")
            } catch {
                Logger.ockStore.error("Error adding tasks: \(error)")
            }
        }
    }

    func addContactsIfNotPresent(_ contacts: [OCKContact]) async throws {
        let contactIdsToAdd = contacts.compactMap { $0.id }

        // Prepare query to see if contacts are already added
        var query = OCKContactQuery(for: Date())
        query.ids = contactIdsToAdd

        let foundContacts = try await fetchContacts(query: query)
        var contactsNotInStore = [OCKContact]()

        // Check results to see if there's a missing task
        contacts.forEach { potential in
            if foundContacts.first(where: { $0.id == potential.id }) == nil {
                contactsNotInStore.append(potential)
            }
        }

        // Only add if there's a new task
        if contactsNotInStore.count > 0 {
            do {
                _ = try await addContacts(contactsNotInStore)
                Logger.ockStore.info("Added contacts into OCKStore!")
            } catch {
                Logger.ockStore.error("Error adding contacts: \(error)")
            }
        }
    }

    func populateCarePlans(patientUUID: UUID? = nil) async throws {
            let checkInCarePlan = OCKCarePlan(id: CarePlanID.checkIn.rawValue,
                                              title: "Check in Care Plan",
                                              patientUUID: patientUUID)
            let healthCarePlan = OCKCarePlan(id: CarePlanID.health.rawValue,
                                                 title: "Health Care Plan",
                                                 patientUUID: patientUUID)
            let productivityCarePlan = OCKCarePlan(id: CarePlanID.productivity.rawValue,
                                                  title: "Productivity Care Plan",
                                                  patientUUID: patientUUID)
            let dietCarePlan = OCKCarePlan(id: CarePlanID.diet.rawValue,
                                                  title: "Diet Care Plan",
                                                  patientUUID: patientUUID)

            try await addCarePlansIfNotPresent([checkInCarePlan, healthCarePlan, productivityCarePlan, dietCarePlan],
                                               patientUUID: patientUUID)
        }

    // Adds tasks and contacts into the store
    func populateSampleData(_ patientUUID: UUID? = nil) async throws {
        let carePlanUUIDs = try await Self.getCarePlanUUIDs()
        try await populateCarePlans(patientUUID: patientUUID)

        let thisMorning = Calendar.current.startOfDay(for: Date())
        guard let aFewDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: thisMorning),
                      let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: aFewDaysAgo),
                      let afterLunch = Calendar.current.date(byAdding: .hour, value: 14, to: aFewDaysAgo) else {
                    Logger.ockStore.error("Could not unwrap calendar. Should never hit")
                    throw AppError.couldntBeUnwrapped
                }

        let schedule = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1)),

            OCKScheduleElement(start: afterLunch,
                               end: nil,
                               interval: DateComponents(day: 2))
        ])
        var breather = OCKTask(id: TaskID.breather,
                                 title: "Take a Breath",
                                 carePlanUUID: nil,
                                 schedule: schedule)
        breather.instructions = "Take a moment to meditate anytime you feeling overwhelmed."
        breather.asset = "pills.fill"
        breather.card = .checklist

        let waterIntakeSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Anytime throughout the day",
                               targetValues: [], duration: .allDay)
            ])

        var waterIntake = OCKTask(id: TaskID.waterIntake,
                             title: "Track your water intake",
                             carePlanUUID: carePlanUUIDs[.waterIntake],
                             schedule: waterIntakeSchedule)
        waterIntake.impactsAdherence = false
        waterIntake.instructions = "Tap the button below anytime you drink a glass of water."
        waterIntake.asset = "waterbottle"
        waterIntake.card = .button

        let kegelElement = OCKScheduleElement(start: beforeBreakfast,
                                              end: nil,
                                              interval: DateComponents(day: 2))
        let kegelSchedule = OCKSchedule(composing: [kegelElement])
        var kegels = OCKTask(id: TaskID.kegels,
                             title: "Kegel Exercises",
                             carePlanUUID: carePlanUUIDs[.kegle],
                             schedule: kegelSchedule)
        kegels.impactsAdherence = true
        kegels.instructions = "Perform kegel exercies"
        kegels.card = .simple
        let alcholicDrinksElement = OCKScheduleElement(start: beforeBreakfast,
                                                end: nil,
                                                interval: DateComponents(day: 1),
                                                text: "Drinks",
                                                targetValues: [], duration: .allDay)
        let alcholicDrinksSchedule = OCKSchedule(composing: [alcholicDrinksElement])

        var alcholicDrinks = OCKTask(id: TaskID.alchoolIntake,
                                   title: "Track alchool intake",
                                   carePlanUUID: carePlanUUIDs[CarePlanID.alchool],
                                   schedule: alcholicDrinksSchedule)
        alcholicDrinks.impactsAdherence = false
        alcholicDrinks.instructions = "It's not recommended to have above one alchooloc drink per day"
        alcholicDrinks.asset = "wineglass"
        alcholicDrinks.card = .custom
        alcholicDrinks.graph = .line
        alcholicDrinks.groupIdentifier = "Drinks" // unit for data series legend
//        let stretchElement = OCKScheduleElement(start: beforeBreakfast,
//                                                end: nil,
//                                                interval: DateComponents(day: 1))
//        let stretchSchedule = OCKSchedule(composing: [stretchElement])
        var stretch = OCKTask(id: TaskID.stretch,
                              title: "Stretch",
                              carePlanUUID: carePlanUUIDs[.stretch],
                              schedule: waterIntakeSchedule)
        stretch.impactsAdherence = true
        stretch.asset = "figure.walk"
        stretch.card = .checklist

        try await addTasksIfNotPresent([waterIntake, breather, kegels, stretch, alcholicDrinks])
        try await addOnboardingTask(carePlanUUIDs[.health])
        try await addSurveyTasks(carePlanUUIDs[.checkIn])
        var contact1 = OCKContact(id: "jane",
                                  givenName: "Jane",
                                  familyName: "Daniels",
                                  carePlanUUID: carePlanUUIDs[.input])
        contact1.asset = "JaneDaniels"
        contact1.title = "Family Practice Doctor"
        contact1.role = "Dr. Daniels is a family practice doctor with 8 years of experience."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "janedaniels@uky.edu")]
        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 257-2000")]
        contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 357-2040")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "2195 Harrodsburg Rd"
            address.city = "Lexington"
            address.state = "KY"
            address.postalCode = "40504"
            return address
        }()

        var contact2 = OCKContact(id: "matthew", givenName: "Matthew",
                                  familyName: "Reiff", carePlanUUID: nil)
        contact2.asset = "MatthewReiff"
        contact2.title = "OBGYN"
        contact2.role = "Dr. Reiff is an OBGYN with 13 years of experience."
        contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 257-1000")]
        contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 257-1234")]
        contact2.address = {
            let address = OCKPostalAddress()
            address.street = "1000 S Limestone"
            address.city = "Lexington"
            address.state = "KY"
            address.postalCode = "40536"
            return address
        }()

        try await addContactsIfNotPresent([contact1, contact2])
    }

    func addOnboardingTask(_ carePlanUUID: UUID? = nil) async throws {
            let onboardSchedule = OCKSchedule.dailyAtTime(
                        hour: 0, minutes: 0,
                        start: Date(), end: nil,
                        text: "Task Due!",
                        duration: .allDay
                    )

            var onboardTask = OCKTask(
                id: Onboard.identifier(),
                title: "Onboard",
                carePlanUUID: carePlanUUID,
                schedule: onboardSchedule
            )
            onboardTask.instructions = "You'll need to agree to some terms and conditions before we get started!"
            onboardTask.impactsAdherence = false
            onboardTask.card = .survey
            onboardTask.survey = .onboard

            try await addTasksIfNotPresent([onboardTask])
        }

        func addSurveyTasks(_ carePlanUUID: UUID? = nil) async throws {
            let checkInSchedule = OCKSchedule.dailyAtTime(
                hour: 8, minutes: 0,
                start: Date(), end: nil,
                text: nil
            )

            var checkInTask = OCKTask(
                id: CheckIn.identifier(),
                title: "Check In",
                carePlanUUID: carePlanUUID,
                schedule: checkInSchedule
            )
            checkInTask.card = .survey
            checkInTask.survey = .checkIn

            let thisMorning = Calendar.current.startOfDay(for: Date())

            let nextWeek = Calendar.current.date(
                byAdding: .weekOfYear,
                value: 1,
                to: Date()
            )!

            let nextMonth = Calendar.current.date(
                byAdding: .month,
                value: 1,
                to: thisMorning
            )

            let dailyElement = OCKScheduleElement(
                start: thisMorning,
                end: nextWeek,
                interval: DateComponents(day: 1),
                text: nil,
                targetValues: [],
                duration: .allDay
            )

            let weeklyElement = OCKScheduleElement(
                start: nextWeek,
                end: nextMonth,
                interval: DateComponents(weekOfYear: 1),
                text: nil,
                targetValues: [],
                duration: .allDay
            )

            let rangeOfMotionCheckSchedule = OCKSchedule(
                composing: [dailyElement, weeklyElement]
            )

            let reactionTimeSchedule = OCKSchedule(
                composing: [dailyElement, weeklyElement]
            )

            var reactionTimeTask = OCKTask(
                id: ReactionTime.identifier(),
                title: "Vision Exercise",
                carePlanUUID: carePlanUUID,
                schedule: reactionTimeSchedule)
            reactionTimeTask.card = .survey
            reactionTimeTask.survey = .reactionTime

            var rangeOfMotionTask = OCKTask(
                id: RangeOfMotion.identifier(),
                title: "Range Of Motion",
                carePlanUUID: carePlanUUID,
                schedule: rangeOfMotionCheckSchedule
            )
            rangeOfMotionTask.card = .survey
            rangeOfMotionTask.survey = .rangeOfMotion

            try await addTasksIfNotPresent([checkInTask, reactionTimeTask])
        }
}

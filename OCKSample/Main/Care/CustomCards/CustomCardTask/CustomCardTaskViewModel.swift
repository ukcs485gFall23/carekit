//
//  CustomCardTaskViewModel.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKitStore
import Foundation
import os.log

class CustomCardTaskViewModel: ObservableObject {

    /// The action performed when an outcome is to be saved
    var action: (OCKAnyStoreProtocol, OCKAnyEvent, OCKOutcomeValue?) async -> Void = { _, _, _   in }

    init() {

        // Set the default action to save an outcome.
        // Can modify this if your outcome saves need to be
        // more sophisticated.
        self.action = { store, event, value in
            do {

                guard let value = value else {
                    // No outcome to set, want to remove outcome
                    guard let outcomeToDelete = event.outcome else {
                        // No outcome to delete
                        return
                    }
                    _ = try await store.deleteAnyOutcome(outcomeToDelete)
                    return
                }

                if var outcomeToUpdate = event.outcome {

                    // Append to previous outcomes
                    var outcomeValuesToUpdate = outcomeToUpdate.values
                    outcomeValuesToUpdate.append(value)
                    outcomeToUpdate.values = outcomeValuesToUpdate

                    _ = try await store.updateAnyOutcome(outcomeToUpdate)
                } else {

                    // Create new outcome
                    let newOutcome = OCKOutcome(
                        taskUUID: event.task.uuid,
                        taskOccurrenceIndex: event.scheduleEvent.occurrence,
                        values: [value]
                    )

                    _ = try await store.addAnyOutcome(newOutcome)
                }

            } catch {
                Logger.customCardTask.error("Could not save outcome: \(error)")
            }
        }

    }

}

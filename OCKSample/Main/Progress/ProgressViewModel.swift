//
//  ProgressViewModel.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKit
import CareKitStore
import Foundation

class ProgressViewModel: ObservableObject {

    static func queryEvents() -> OCKEventQuery {
        var query = OCKEventQuery(for: Date())
        query.taskIDs = [TaskID.steps, TaskID.moveTime, TaskID.waterIntake, TaskID.standingTime, TaskID.alchoolIntake]

        return query
    }

}

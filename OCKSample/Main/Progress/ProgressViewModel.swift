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
        // yTODO: Constrain your query to your specific needs
        var query = OCKEventQuery(for: Date())
        // Add any taskID you want to show on a card here, these are only examples.
        query.taskIDs = [TaskID.steps, TaskID.doxylamine]

        return query
    }

}

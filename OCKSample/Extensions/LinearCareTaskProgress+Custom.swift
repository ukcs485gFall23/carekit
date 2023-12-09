//
//  LinearCareTaskProgress+Custom.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKitStore
import Foundation

extension LinearCareTaskProgress {

    /// Format the `value` for display.
    func valueDescription(formatter: NumberFormatter?) -> String {
        let progressDescription = formatter.map { $0.string(from: NSNumber(value: value)) }
            ?? value.removingExtraneousDecimal()
        return progressDescription ?? "\(value)"
    }

    /// Format the `goal` for display.
    func goalDescription(formatter: NumberFormatter?) -> String {

        guard let goal else {

            return ""
        }

        let targetDescription = formatter.map { $0.string(from: NSNumber(value: goal)) }
            ?? goal.removingExtraneousDecimal()

        return targetDescription ?? "\(goal)"
    }
}

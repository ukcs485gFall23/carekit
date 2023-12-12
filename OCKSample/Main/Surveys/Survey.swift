//
//  Survey.swift
//  OCKSample
//
//  Created by  on 11/16/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore

enum Survey: String, CaseIterable, Identifiable {
    var id: Self { self }
    case onboard = "Onboard"
    case checkIn = "Check In"
    case rangeOfMotion = "Range of Motion"
    case reactionTime = "Reaction Time"

    func type() -> Surveyable {
        switch self {
        case .onboard:
            return Onboard()
        case .checkIn:
            return CheckIn()
        case .rangeOfMotion:
            return RangeOfMotion()
        case .reactionTime:
            return ReactionTime()
        }
    }
}

//
//  CarePlanID.swift
//  OCKSample
//
//  Created by Elnoel Akwa on 11/13/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

// Done hw5
enum CarePlanID: String, CaseIterable, Identifiable {
    var id: Self { self }
    case input = "input"
    case checkIn = "check In"
    case stat
    case health
    case moveTime
    case standingTime
    case productivity = "productivity"
    case stretch = "stretch"
    case diet = "diet"
    case waterIntake = "waterIntake"
    case steps = "steps"
    case kegle = "kagle"
    case alchool = "alchool"
}

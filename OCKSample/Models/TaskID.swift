//
//  TaskID.swift
//  OCKSample
//
//  Created by Corey Baker on 4/14/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum TaskID {
    static let breather = "breather"
    static let waterIntake = "water intake"
    static let stretch = "stretch"
    static let kegels = "kegels"
    static let steps = "steps"
    static let alchoolIntake = "alchool"
    static let standingTime = "stand time"
    static let moveTime = "move time"

    static var ordered: [String] {
        [Self.steps, Self.alchoolIntake, Self.standingTime, Self.stretch, Self.waterIntake, self.moveTime]
    }
}

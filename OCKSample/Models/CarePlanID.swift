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
    var id: String {
        return UUID().uuidString}
    case health = "health"
    case checkIn = "check In"
    case productivity = "productivity"
    case diet = "diet"
}

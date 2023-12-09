//
//  Graphs.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum GraphCard: String, CaseIterable, Identifiable {
    var id: Self { self }
    case checkIn = "Check In"
    case bar = "Bar"
    case line = "Line"
    case scatter = "Scatter"
}

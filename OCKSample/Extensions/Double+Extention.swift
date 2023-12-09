//
//  Double+Extention.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

extension Double {

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter

    }()

    /// Remove decimal if it equals 0, and round to two decimal places
    func removingExtraneousDecimal() -> String? {
        return Self.formatter.string(from: self as NSNumber)
    }
}

//
//  OCKAnyEvent+Custom.swift
//  OCKSample
//
//  Created by Elnoel Akwa on 11/16/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKitStore

extension OCKAnyEvent {

    func answer(kind: String) -> Double {
        let values = outcome?.values ?? []
        let match = values.first(where: { $0.kind == kind })
        return match?.doubleValue ?? 0
    }
}

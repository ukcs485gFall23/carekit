//
//  ContactViewModel.swift
//  OCKSample
//
//  Created by Elnoel Akwa on 11/7/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKitStore
import Foundation

class ContactViewModel: ObservableObject {

    static func contactQuery() -> OCKContactQuery {

        let query = OCKContactQuery(for: Date())
        // BAKER: Appears to be a bug in CareKit, commenting these out for now
        // query.sortDescriptors.append(.familyName(ascending: true))
        // query.sortDescriptors.append(.givenName(ascending: true))

        return query
    }

}

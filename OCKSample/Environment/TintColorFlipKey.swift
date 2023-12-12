//
//  TintColorFlipKey.swift
//  OCKSample
//
//  Created by Corey Baker on 9/26/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import SwiftUI

struct TintColorFlipKey: EnvironmentKey {
    static var defaultValue: UIColor {
        #if os(iOS)
        return UIColor { $0.userInterfaceStyle == .light ?  #colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 1) : #colorLiteral(red: 0, green: 0.3959179223, blue: 0.497296989, alpha: 1) }
        #else
        return #colorLiteral(red: 0.4980392157, green: 1, blue: 0.831372549, alpha: 1)
        #endif
    }
}

extension EnvironmentValues {
    var tintColorFlip: UIColor {
        self[TintColorFlipKey.self]
    }
}

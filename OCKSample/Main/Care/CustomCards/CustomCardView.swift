//
//  CustomCardView.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKitUI
import SwiftUI

struct CustomCardView: View {
    @Environment(\.tintColor) private var tintColor
    @Environment(\.careKitStyle) var style

    var body: some View {
        CardView {
            VStack(alignment: .leading,
                   spacing: style.dimension.directionalInsets1.top) {

                HStack(spacing: style.dimension.directionalInsets2.trailing) {
                    Image(systemName: "hand.raised.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 30)
                        .foregroundColor(Color(tintColor))
                    Spacer()
                    Text("Hello, World!")

                }

            }.padding()
        }

    }
}

// Only need to make this change for older Xcode, otherwise use #Preview.
struct CustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCardView()
            .accentColor(Color(TintColorKey.defaultValue))
            .environment(\.appDelegate, AppDelegate())
            .environment(\.careStore, Utility.createPreviewStore())
    }
}

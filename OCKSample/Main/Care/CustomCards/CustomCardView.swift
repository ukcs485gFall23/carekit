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
    @State private var puns = [
            "Why don't programmers fight each other? They don't want to start a Ctrl war!",
            "Did you hear about the software developer who died? He coded his last line!",
            "I'm reading a book about anti-virus software. It's infectiously funny!",
            "What do you call a fake software? An impastacode!",
            "I'm reading a book on coding errors. It's hard to debug my laughter!"
        ]
    @State private var displayedPun = "I'm on a data diet. I see bytes and I byte it"

    var body: some View {
            CardView {
                VStack(alignment: .leading,
                       spacing: style.dimension.directionalInsets1.top) {

                    HStack(spacing: style.dimension.directionalInsets2.trailing) {
                        Image(systemName: "flag.2.crossed")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 25, height: 40)
                            .foregroundColor(Color(tintColor))
                        Spacer()
                        Text(displayedPun)
                            .onAppear {
                                shufflePuns()
                            }
                    }

                }.padding()
            }
        }

        func shufflePuns() {
            puns.shuffle()
            displayedPun = puns.first ?? "I told my computer it should embrace its bugs. It crashed on me."
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

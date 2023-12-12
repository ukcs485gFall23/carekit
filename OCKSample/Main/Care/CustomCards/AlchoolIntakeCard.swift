//
//  AlchoolIntakeCard.swift
//  OCKSample
//
//  Created by  on 12/12/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKitUI
import SwiftUI

struct AlcoholIntakeCard: View {
    @Environment(\.tintColor) private var tintColor
    @Environment(\.careKitStyle) var style
    @State private var numberOfDrinks: String = ""

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: style.dimension.directionalInsets1.top) {
                HStack(spacing: style.dimension.directionalInsets2.trailing) {
                    Image(systemName: "flag.2.crossed")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 35)
                        .foregroundColor(Color(tintColor))
                    Spacer()
                    Text("Alcohol Intake")
                        .font(.headline)
                        .bold()
                }
                TextField("How many drinks have you had today?", text: $numberOfDrinks)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 8)
            }
            .padding()
        }
    }
}

struct AlcoholIntakeCard_Previews: PreviewProvider {
    static var previews: some View {
        AlcoholIntakeCard()
            .accentColor(Color(TintColorKey.defaultValue))
            .environment(\.appDelegate, AppDelegate())
            .environment(\.careStore, Utility.createPreviewStore())
    }
}

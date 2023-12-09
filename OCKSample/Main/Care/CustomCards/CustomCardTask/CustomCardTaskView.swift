//
//  CustomCardTaskView.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import CareKit
import CareKitStore
import CareKitUI
import CareKitUtilities
import SwiftUI

struct CustomCardTaskView: View {
    @Environment(\.tintColor) private var tintColor
    @Environment(\.careKitStyle) var style
    @Environment(\.careStore) private var careStore
    @ObservedObject var viewModel = CustomCardTaskViewModel()

    let event: CareStoreFetchedResult<OCKAnyEvent>
    let numberFormatter: NumberFormatter? = nil

    var body: some View {
        CardView {
            VStack(alignment: .leading,
                   spacing: style.dimension.directionalInsets1.top) {

                let currentEvent = event.result
                InformationHeaderView(
                    title: Text(currentEvent.title),
                    event: currentEvent
                )

                Divider()

                let progress = event.result.computeProgress(by: .summingOutcomeValues)
                HStack(spacing: style.dimension.directionalInsets2.trailing) {

                    HStack {
                        // Display progress
                        Text("\(progress.valueDescription(formatter: numberFormatter))/")
                        Text("\(progress.goalDescription(formatter: numberFormatter))")
                    }

                    Spacer()

                    Button(action: {

                        let newOutcomeValue: OCKOutcomeValue?

                        if !progress.isCompleted {
                            // If currently not completed, complete it
                            newOutcomeValue = OCKOutcomeValue(true)
                        } else {
                            // Else, we want to delete the current outcome
                            newOutcomeValue = nil
                        }

                        Task {
                            await viewModel.action(careStore, currentEvent, newOutcomeValue)
                        }

                    }) {
                        // CareKit provides you with a completion view if needed.
                        RectangularCompletionView(isComplete: progress.isCompleted) {
                            Image(systemName: "checkmark") // Can place any view type here
                                .resizable()
                                .padding()
                                .frame(width: 50, height: 50) // Change size to make larger/smaller
                        }
                        /*
                        // Heres an example of a different completion view
                        CircularCompletionView(isComplete: progress.isCompleted) {
                            Image(systemName: "checkmark") // Can place any view type here
                                .resizable()
                                .padding()
                                .frame(width: 50, height: 50) // Change size to make larger/smaller
                        } */
                    }

                }

            }.padding()
        }
    }
}

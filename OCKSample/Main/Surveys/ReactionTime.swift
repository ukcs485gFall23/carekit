//
//  ReactionTime.swift
//  OCKSample
//
//  Created by Elnoel Akwa on 12/11/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import ResearchKit
import CareKitStore

struct ReactionTime: Surveyable{
    static var surveyType: Survey{
        Survey.reactionTime
    }
}

extension ReactionTime{
    func createSurvey() -> ORKTask {
        let reationTimeTask = ORKOrderedTask.reactionTime(withIdentifier: identifier(),
                                                          intendedUseDescription: "Get user's reaction time", maximumStimulusInterval: 10, minimumStimulusInterval: 10, thresholdAcceleration: 0.5, numberOfAttempts: 1, timeout: 3, successSound: UInt32(kSystemSoundID_Vibrate), timeoutSound: UInt32(kSystemSoundID_Vibrate), failureSound: UInt32(kSystemSoundID_Vibrate), options: [])
        let completionStep = ORKCompletionStep(identifier: "\(identifier()).completion")
        completionStep.title = "All done!"
        completionStep.detailText = "Great job relaxing your eyes!"

        return reationTimeTask
    }
    func extractAnswers(_ result: ORKTaskResult) -> [OCKOutcomeValue]? {
        guard let motionResult = result.results?
            .compactMap({ $0 as? ORKStepResult })
            .compactMap({ $0.results })
            .flatMap({ $0 })
            .compactMap({ $0 as? ORKRangeOfMotionResult })
            .first else {

            assertionFailure("Failed to parse range of motion result")
            return nil
        }

        var range = OCKOutcomeValue(motionResult.range)
        range.kind = #keyPath(ORKNormalizedReactionTimeResult.currentInterval)

        return [range]
    }
}

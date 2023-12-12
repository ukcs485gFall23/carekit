//
//  InsightsViewContoller.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import UIKit
import CareKit
import CareKitStore
import CareKitUI
import CareKitUtilities
import ParseCareKit
import os.log

class InsightsViewController: OCKListViewController {

    let store: OCKAnyStoreProtocol

    /// Create an instance of the view controller. Will hook up the calendar to the tasks collection,
    /// and query and display the tasks.
    ///
    /// - Parameter store: The store from which to query the tasks.
    init(
        store: OCKAnyStoreProtocol
    ) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Insights"

        Task {
            await displayTasks(Date())
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        Task {
            await displayTasks(Date())
        }
    }

    override func appendViewController(_ viewController: UIViewController, animated: Bool) {
        super.appendViewController(viewController, animated: animated)

        // Make sure this contact card matches app style when possible
        if let carekitView = viewController.view as? OCKView {
            carekitView.customStyle = CustomStylerKey.defaultValue
        }
    }

    @MainActor
    func fetchTasks(on date: Date) async -> [OCKAnyTask] {

        var query = OCKTaskQuery(for: date)
        query.excludesTasksWithNoEvents = true
        do {
            let tasks = try await store.fetchAnyTasks(query: query)
            var taskIDs = TaskID.ordered
            taskIDs.append(CheckIn().identifier())
            let orderedTasks = taskIDs.compactMap { orderedTaskID in
                tasks.first(where: { $0.id == orderedTaskID }) }
            return orderedTasks
        } catch {
            Logger.insights.error("\(error.localizedDescription, privacy: .public)")
            return []
        }
    }

    /*
    Plot all of your tasks in this method. Note that you can combine multiple
     tasks into one chart (like the Nausea/Doxlymine chart if they are related.
    */

    func taskViewController(for task: OCKAnyTask, on date: Date) -> [UIViewController]? {
            let graph: GraphCard!
            if let task = task as? OCKTask {
                graph = task.graph
            } else if let task = task as? OCKHealthKitTask {
                graph = task.graph
            } else {
                return nil
            }

            switch graph {
            case .checkIn:
                let survey = CheckIn() // Only used for example.
                let surveyTaskID = survey.identifier() // Only used for example.
                /*
                 Note that that there's a small bug for the check in graph because
                 it averages all of the "Pain + Sleep" hours. This okay for now. If
                 you are collecting ResearchKit input that only collects 1 value per
                 survey, you won't have this problem.
                 */

                // dynamic gradient colors
                let meanGradientStart = TintColorFlipKey.defaultValue
                let meanGradientEnd = TintColorKey.defaultValue

                let meanDataSeries = OCKDataSeriesConfiguration(
                    taskID: surveyTaskID,
                    legendTitle: "Mean of Sleep Data",
                    gradientStartColor: meanGradientStart,
                    gradientEndColor: meanGradientEnd,
                    markerSize: 10) { event in
                        event.computeProgress(by: .summingOutcomeValues)
                    }

                let medianDataSeries = OCKDataSeriesConfiguration(
                    taskID: surveyTaskID,
                    legendTitle: "Median of Sleep Data",
                    gradientStartColor: .systemGray2,
                    gradientEndColor: .systemGray,
                    markerSize: 10) { event in
                        event.computeProgress(by: .summingOutcomeValues)
                    }

                let insightsCard = OCKCartesianChartViewController(
                    plotType: .line,
                    selectedDate: date,
                    configurations: [meanDataSeries, medianDataSeries],
                    store: self.store)

                insightsCard.typedView.headerView.titleLabel.text = "Sleep Mean & Median"
                insightsCard.typedView.headerView.detailLabel.text = "This Week"
                insightsCard.typedView.headerView.accessibilityLabel = "Mean & Median, This Week"

                return [insightsCard]

            case .bar:
                let barGradientStart = TintColorFlipKey.defaultValue
                let barGradientEnd = TintColorKey.defaultValue

                let dataSeries = OCKDataSeriesConfiguration(
                    taskID: task.id,
                    legendTitle: task.groupIdentifier ?? "Bar Chart",
                    gradientStartColor: barGradientStart,
                    gradientEndColor: barGradientEnd,
                    markerSize: 10) { event in
                        event.computeProgress(by: .summingOutcomeValues)
                    }

                let insightsCard = OCKCartesianChartViewController(
                    plotType: .bar,
                    selectedDate: date,
                    configurations: [dataSeries],
                    store: self.store)

                insightsCard.typedView.headerView.titleLabel.text = task.title
                insightsCard.typedView.headerView.detailLabel.text = task.instructions
                insightsCard.typedView.headerView.accessibilityLabel = task.title

                return [insightsCard]

            case .line:
                let lineGradientStart = TintColorFlipKey.defaultValue
                let lineGradientEnd = TintColorKey.defaultValue

                let dataSeries = OCKDataSeriesConfiguration(
                    taskID: task.id,
                    legendTitle: task.groupIdentifier ?? "Line Chart",
                    gradientStartColor: lineGradientStart,
                    gradientEndColor: lineGradientEnd,
                    markerSize: 5) { event in
                        event.computeProgress(by: .summingOutcomeValues)
                    }

                let insightsCard = OCKCartesianChartViewController(
                    plotType: .line,
                    selectedDate: date,
                    configurations: [dataSeries],
                    store: self.store)

                insightsCard.typedView.headerView.titleLabel.text = task.title
                insightsCard.typedView.headerView.detailLabel.text = task.instructions
                insightsCard.typedView.headerView.accessibilityLabel = task.title

                return [insightsCard]

            case .scatter:
                let scatterGradientStart = TintColorFlipKey.defaultValue
                let scatterGradientEnd = TintColorKey.defaultValue

                let dataSeries = OCKDataSeriesConfiguration(
                    taskID: task.id,
                    legendTitle: task.groupIdentifier ?? "Scatter Chart",
                    gradientStartColor: scatterGradientStart,
                    gradientEndColor: scatterGradientEnd,
                    markerSize: 5) { event in
                        event.computeProgress(by: .summingOutcomeValues)
                    }

                let insightsCard = OCKCartesianChartViewController(
                    plotType: .scatter,
                    selectedDate: date,
                    configurations: [dataSeries],
                    store: self.store)

                insightsCard.typedView.headerView.titleLabel.text = task.title
                insightsCard.typedView.headerView.detailLabel.text = task.instructions
                insightsCard.typedView.headerView.accessibilityLabel = task.title

                return [insightsCard]

            default:
                return nil
            }
        }

        @MainActor
        func displayTasks(_ date: Date) async {

            let tasks = await fetchTasks(on: date)
            self.clear() // Clear after pulling tasks from database
            tasks.compactMap {
                let cards = self.taskViewController(for: $0, on: date)
                cards?.forEach {
                    if let carekitView = $0.view as? OCKView {
                        carekitView.customStyle = CustomStylerKey.defaultValue
                    }
                }
                return cards
            }.forEach { (cards: [UIViewController]) in
                cards.forEach {
                    self.appendViewController($0, animated: false)
                }
            }
        }
    }

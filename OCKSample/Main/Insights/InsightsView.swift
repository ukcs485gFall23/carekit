//
//  InsightsView.swift
//  OCKSample
//
//  Created by  on 12/9/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI

struct InsightsView: UIViewControllerRepresentable {
    @Environment(\.careStore) private var careStore

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = InsightsViewController(store: careStore)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: Context) {}
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}

//
//  EmptyStateUI.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import SwiftUI

// Reusable empty state view with custom title to tell the user no results were returned
public struct EmptyStateUI: View {

    private let title: String
    private let retryAction: () async -> Void

    public init(title: String, retryAction: @escaping () async -> Void) {
        self.title = title
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack(spacing: 48) {
            Text(.title3(text: title, fontWeight: .semibold))
            Button(
                action: {
                    Task {
                        await retryAction()
                    }
                },
                label: {
                    Text("Retry")
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateUI(title: "No Results", retryAction: {})
}

//
//  View+Extension.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/14/25.
//

import SwiftUI
import Shimmer

extension View {
    var customListStyle: some View {
        self
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }

    func shimmeringUI(isLoading: Bool) -> some View {
        if isLoading {
            return AnyView(self
                .redacted(reason: .placeholder)
                .shimmering()
            )
        } else {
            return AnyView(self)
        }
    }

    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

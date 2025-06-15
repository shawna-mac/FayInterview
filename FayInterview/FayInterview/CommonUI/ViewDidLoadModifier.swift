//
//  ViewDidLoadModifier.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Foundation
import SwiftUI

public extension View {

    /// Load data only once after view appears
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

public struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    public init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    public func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

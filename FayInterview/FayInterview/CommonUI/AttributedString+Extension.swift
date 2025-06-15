//
//  AttributedString+Extension.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Foundation
import SwiftUI

public extension AttributedString {

    /// Body Style
    /// - Parameters:
    ///     - text: the string to style
    ///     - fontWeight: weight of font to style text
    ///     - color: color to style the text
    /// - Returns: AttributedString
    static func body(text: String, fontWeight: Font.Weight = .regular, color: Color = Color.black) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.font = .system(size: 16, weight: fontWeight)
        attributedString.foregroundColor = color
        return attributedString
    }

    /// Body2 Style
    /// - Parameters:
    ///     - text: the string to style
    ///     - fontWeight: weight of font to style text
    ///     - color: color to style the text
    /// - Returns: AttributedString
    static func body2(text: String, fontWeight: Font.Weight = .regular, color: Color = Color.black) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.font = .system(size: 14, weight: fontWeight)
        attributedString.foregroundColor = color
        return attributedString
    }

    /// Caption Style
    /// - Parameters:
    ///     - text: the string to style
    ///     - fontWeight: weight of font to style text
    ///     - color: color to style the text
    /// - Returns: AttributedString
    static func caption(text: String, fontWeight: Font.Weight = .regular, color: Color = Color.black) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.font = .system(size: 12, weight: fontWeight)
        attributedString.foregroundColor = color
        return attributedString
    }

    /// Title2Style
    /// - Parameters:
    ///     - text: the string to style
    ///     - fontWeight: weight of font to style text
    ///     - color: color to style the text
    /// - Returns: AttributedString
    static func title2(text: String, fontWeight: Font.Weight = .regular, color: Color = Color.black) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.font = .system(size: 24, weight: fontWeight)
        attributedString.foregroundColor = color
        return attributedString
    }

    /// Title3 Style
    /// - Parameters:
    ///     - text: the string to style
    ///     - fontWeight: weight of font to style text
    ///     - color: color to style the text
    /// - Returns: AttributedString
    static func title3(text: String, fontWeight: Font.Weight = .regular, color: Color = Color.black) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.font = .system(size: 20, weight: fontWeight)
        attributedString.foregroundColor = color
        return attributedString
    }
}

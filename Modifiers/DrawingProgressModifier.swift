//
//  DrawingProgressModifier.swift
//  TIA
//
//  Created by serhii.lomov on 14.06.2022.
//

import Foundation
import SwiftUI

struct DrawingProgressModifier: AnimatableModifier {

    var drawingProgress: DrawingProgress
    var animatableData: DrawingProgress {
        get { drawingProgress }
        set { drawingProgress = newValue  }
    }

    func body(content: Content) -> some View {
        content
            .environment(\.drawingProgress, drawingProgress)
    }
}

struct DrawingProgress: VectorArithmetic {
    static var zero: DrawingProgress = DrawingProgress(value: .zero)
    static var full: DrawingProgress = DrawingProgress(value: 1)

    var value: CGFloat
    var magnitudeSquared: Double { value * value }

    mutating func scale(by rhs: Double) {
        value *= rhs
    }

    static func + (lhs: DrawingProgress, rhs: DrawingProgress) -> DrawingProgress {
        .init(value: lhs.value + rhs.value)
    }

    static func - (lhs: DrawingProgress, rhs: DrawingProgress) -> DrawingProgress {
        .init(value: lhs.value - rhs.value)
    }

}

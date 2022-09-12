//
//  EnvironmentKeys.swift
//  TIA
//
//  Created by serhii.lomov on 23.06.2022.
//

import SwiftUI

struct DrawingWidthKey: EnvironmentKey {
    static var defaultValue: CGFloat = 1
}

struct DrawingProgressKey: EnvironmentKey {
    static var defaultValue: DrawingProgress = .zero
}

enum ControlsShowingMode {
    case none
    case selected
    case all
}

struct ControlsShowingModeKey: EnvironmentKey {
    static var defaultValue: ControlsShowingMode = .none
}

extension EnvironmentValues {
    var drawingWidth: CGFloat {
        get { self[DrawingWidthKey.self] }
        set { self[DrawingWidthKey.self] = newValue }
    }

    var drawingProgress: DrawingProgress {
        get { self[DrawingProgressKey.self] }
        set { self[DrawingProgressKey.self] = newValue }
    }

    var controlsShowingMode: ControlsShowingMode {
        get { self[ControlsShowingModeKey.self] }
        set { self[ControlsShowingModeKey.self] = newValue }
    }
}

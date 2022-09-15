//
//  CurvesThread.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 14.09.2022.
//

import Foundation

enum CurveCrossing {
    case middle, top, bottom, custom(Int)

    var layer: Int {
        switch self {
        case .middle: return 100
        case .top: return 200
        case .bottom: return 0
        case .custom(let layer): return layer
        }
    }
}

struct ThreadCurve {
    var curve: BezierCurve
    var crossing: CurveCrossing
    var startAt: CGFloat
    var finishAt: CGFloat

    init(curve: BezierCurve, crossing: CurveCrossing = .middle, startAt: CGFloat = 0, finishAt: CGFloat = 0) {
        self.curve = curve
        self.crossing = crossing
        self.startAt = startAt
        self.finishAt = finishAt
    }

    func transformed(transformer: (BezierCurve) -> BezierCurve) -> ThreadCurve {
        .init(curve: transformer(curve), crossing: crossing, startAt: startAt, finishAt: finishAt)
    }
}

struct CurvesThread {
    var name: String
    var curves: [ThreadCurve]

    static func empty() -> CurvesThread {
        return CurvesThread(name: UUID().uuidString, curves: [])
    }
}

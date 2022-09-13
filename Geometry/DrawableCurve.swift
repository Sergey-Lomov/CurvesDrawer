//
//  DrawableCurve.swift
//  TIA
//
//  Created by serhii.lomov on 14.06.2022.
//

import Foundation
import CoreGraphics

//struct UnderstrokeArea: Hashable {
//    let from: CGFloat
//    let to: CGFloat
//}

struct DrawableCurve {
    let id = UUID().uuidString
    var curve: BezierCurve
    let startAt: CGFloat
    let finishAt: CGFloat
    let widthMult: CGFloat
//    var understrokes = [UnderstrokeArea]()

    init(curve: BezierCurve, startAt: CGFloat, finishAt: CGFloat, widthMult: CGFloat = 1) {
        self.curve = curve
        self.startAt = startAt
        self.finishAt = finishAt
        self.widthMult = widthMult
    }

    func scaled(_ scale: CGFloat) -> DrawableCurve {
        DrawableCurve(curve: curve.scaled(scale), startAt: startAt, finishAt: finishAt, widthMult: widthMult)
    }
//
//    mutating func addUnderstroke(from: CGFloat, to: CGFloat) {
//        understrokes.append(.init(from: from, to: to))
//    }

    func timeScaled(_ scale: CGFloat) -> DrawableCurve {
        DrawableCurve(curve: curve, startAt: startAt * scale, finishAt: finishAt * scale, widthMult: widthMult)
    }

    func timeTranslated(_ delta: CGFloat) -> DrawableCurve {
        DrawableCurve(curve: curve, startAt: startAt + delta, finishAt: finishAt + delta, widthMult: widthMult)
    }
}

extension Array where Element == DrawableCurve {
    func scaled(_ scale: CGFloat) -> [Element] {
        map { $0.scaled(scale) }
    }
}

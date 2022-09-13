//
//  LineSegment.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 13.09.2022.
//

import Foundation
import CoreGraphics

struct LineSegment {
    let from: CGPoint
    let to: CGPoint

    func subsegment(from start: CGFloat, to finish: CGFloat) -> LineSegment {
        let angle = Math.angle(p1: to, p2: from)
        let distance = from.distanceTo(to)
        let p1 = CGPoint(center: from, angle: angle, radius: distance * start)
        let p2 = CGPoint(center: from, angle: angle, radius: distance * finish)
        return LineSegment(from: p1, to: p2)
    }

    func toCurve() -> BezierCurve {
        .line(from: from, to: to)
    }
}

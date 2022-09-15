//
//  DrawgramBuilder.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 13.09.2022.
//

import Foundation

@resultBuilder struct DrawgramBuilder {

    static func buildBlock() -> [DrawableCurve] { [] }

    static func buildBlock(_ commands: DrawgramBuildingCommand...) -> [DrawableCurve] {
        var context = DrawgramBuildingContext()
        commands.forEach { $0.execute(in: &context) }
        
        var threadCurves = context.threads.flatMap { $0.curves }
        threadCurves.sort { $0.crossing.layer < $1.crossing.layer }
        return threadCurves.map {
            DrawableCurve(curve: $0.curve, startAt: $0.startAt, finishAt: $0.finishAt)
        }
    }
}

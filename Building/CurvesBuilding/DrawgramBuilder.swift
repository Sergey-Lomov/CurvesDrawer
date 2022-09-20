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
        
        var threadsCurves = context.threads.flatMap { $0.curves }
        threadsCurves.sort { $0.crossing.layer < $1.crossing.layer }
        let threadsDrawables = threadsCurves.map {
            DrawableCurve(curve: $0.curve, startAt: $0.startAt, finishAt: $0.finishAt)
        }

        var result = [DrawableCurve](context.rawCurves)
        result.append(contentsOf: threadsDrawables)
        return result
    }
}

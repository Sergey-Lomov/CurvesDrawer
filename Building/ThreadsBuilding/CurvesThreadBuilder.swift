//
//  CurvesThreadBuilder.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 14.09.2022.
//

import Foundation

@resultBuilder struct CurvesThreadBuilder {

    static func buildBlock() -> CurvesThread { CurvesThread.empty() }

    static func buildBlock(_ commands: CurvesThreadBuildingCommand...) -> CurvesThread {
        var context = CurvesThreadBuildingContext()
        commands.forEach { $0.execute(in: &context) }
        context.finalize()
        return CurvesThread(name: context.name, curves: context.curves)
    }
}

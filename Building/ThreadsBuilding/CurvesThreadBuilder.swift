//
//  CurvesThreadBuilder.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 14.09.2022.
//

import Foundation

@resultBuilder struct CurvesThreadBuilder {

    static func buildBlock() -> CurvesThread { CurvesThread.empty() }

    static func buildBlock(_ commands: CurvesThreadBuildingCommand...) -> CurvesThreadBuildingCommand {
        return TB.Utils.Group(subcommands: commands)
    }

    static func buildFinalResult(_ command: CurvesThreadBuildingCommand) -> CurvesThread {
        var context = CurvesThreadBuildingContext()
        command.execute(in: &context)
        context.finalize()
        return CurvesThread(name: context.name, curves: context.curves)
    }

    static func buildExpression(_ expression: CurvesThreadBuildingCommand) -> CurvesThreadBuildingCommand {
        expression
    }

    static func buildExpression(_ expression: CurvesThreadBuildingCommand?) -> CurvesThreadBuildingCommand {
        expression ?? TB.Utils.Group(subcommands: [])
    }

    static func buildExpression(_ expression: BezierCurve) -> CurvesThreadBuildingCommand {
        TB.Add.Curve(curve: expression)
    }

    static func buildOptional(_ command: CurvesThreadBuildingCommand?) -> CurvesThreadBuildingCommand {
        guard let command = command else { return TB.Utils.Group.empty }
        return TB.Utils.Group(subcommands: [command])
    }

    public static func buildIf(_ command: CurvesThreadBuildingCommand?) -> CurvesThreadBuildingCommand {
        command ?? TB.Utils.Group(subcommands: [])
    }

    static func buildEither(first: CurvesThreadBuildingCommand) -> CurvesThreadBuildingCommand {
        return first
    }

    static func buildEither(second: CurvesThreadBuildingCommand) -> CurvesThreadBuildingCommand {
        return second
    }

    static func buildArray(_ commands: [CurvesThreadBuildingCommand]) -> CurvesThreadBuildingCommand {
        return TB.Utils.Group(subcommands: commands)
    }
}

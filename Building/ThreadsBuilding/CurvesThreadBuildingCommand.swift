//
//  CurvesThreadBuildingCommand.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 14.09.2022.
//

import Foundation

protocol CurvesThreadBuildingCommand {
    func execute(in context: inout CurvesThreadBuildingContext)
}

struct TB {

    // MARK: Thread commands group
    struct Utils {
        struct Group: CurvesThreadBuildingCommand {
            static let empty = Group(subcommands: [])

            let subcommands: [CurvesThreadBuildingCommand]

            func execute(in context: inout CurvesThreadBuildingContext) {
                subcommands.forEach { $0.execute(in: &context) }
            }
        }
    }

    // MARK: Thread commands group
    struct Thread {

        struct Name: CurvesThreadBuildingCommand {
            let name: String

            init(_ name: String) {
                self.name = name
            }

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.setName(name)
            }
        }

        struct Start: CurvesThreadBuildingCommand {
            let curve: BezierCurve

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.start(from: curve)
            }
        }
    }

    // MARK: Timestamp commands group
    struct Timestamp: CurvesThreadBuildingCommand {
        let timestamp: CGFloat

        init(_ timestamp: CGFloat) {
            self.timestamp = timestamp
        }

        func execute(in context: inout CurvesThreadBuildingContext) {
            context.addTimestamp(timestamp)
        }
    }

    // MARK: Add commands group
    struct Add {

        struct Line: CurvesThreadBuildingCommand {
            let from: CGPoint
            let to: CGPoint

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.addLine(from: from, to: to)
            }
        }

        struct Curve: CurvesThreadBuildingCommand {
            let curve: BezierCurve

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.addCurve(curve)
            }
        }
    }

    // MARK: Continue commands group
    struct Continue {

        struct Line: CurvesThreadBuildingCommand {
            let to: CGPoint

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.continueLine(to: to)
            }
        }

        struct Curve: CurvesThreadBuildingCommand {
            let to: CGPoint
            let c1: CGPoint
            let c2: CGPoint

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.continueCurve(to: to, c1: c1, c2: c2)
            }
        }
    }

    // MARK: Repeat commands group
    struct Repeat {

        struct Mirrored: CurvesThreadBuildingCommand {
            let point: CGPoint

            init(point: CGPoint = .zero) {
                self.point = point
            }

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.addMirroredCurves(center: point)
            }
        }

        struct SelfMirrored: CurvesThreadBuildingCommand {
            let reversion: Bool

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.addSelfMirroredCurves(reversion: reversion)
            }
        }

        struct Rotated: CurvesThreadBuildingCommand {
            let amount: Int?
            let center: CGPoint
            let angle: CGFloat

            init(last amount: Int? = nil, center: CGPoint = .zero, angle: CGFloat) {
                self.amount = amount
                self.center = center
                self.angle = angle
            }

            func execute(in context: inout CurvesThreadBuildingContext) {
                context.addRotatedCurves(amount: amount, center: center, angle: angle)
            }
        }
    }

    // MARK: Crossing commands group
    struct Crossing: CurvesThreadBuildingCommand {
        let crossings: [CurveCrossing]

        init (_ crossings: CurveCrossing...) {
            self.crossings = crossings
        }

        func execute(in context: inout CurvesThreadBuildingContext) {
            context.applyCrossings(crossings)
        }
    }
}

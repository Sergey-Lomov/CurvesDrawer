//
//  DrawgramBuildingCommand.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 13.09.2022.
//

import Foundation

protocol DrawgramBuildingCommand {
    func execute(in context: inout DrawgramBuildingContext)
}

struct CB {
    struct AddThread: DrawgramBuildingCommand {
        @CurvesThreadBuilder let builder: () -> CurvesThread

        func execute(in context: inout DrawgramBuildingContext) {
            context.addThread(builder())
        }
    }

    struct MirroredThread: DrawgramBuildingCommand {
        let source: String
        let name: String
        let center: CGPoint

        init(source: String, name: String, center: CGPoint = .zero) {
            self.source = source
            self.name = name
            self.center = center
        }

        func execute(in context: inout DrawgramBuildingContext) {
            context.addTransformed(source: source, name: name) {
                let curve = $0.curve.mirrored(by: center)
                return ThreadCurve(curve: curve, crossing: $0.crossing, startAt: $0.startAt, finishAt: $0.finishAt)
            }
        }
    }

    struct RotatedThread: DrawgramBuildingCommand {
        let source: String
        let name: String
        let center: CGPoint
        let angle: CGFloat

        init(source: String, name: String, center: CGPoint = .zero, angle: CGFloat) {
            self.source = source
            self.name = name
            self.center = center
            self.angle = angle
        }

        func execute(in context: inout DrawgramBuildingContext) {
            context.addTransformed(source: source, name: name) {
                let curve = $0.curve.rotated(center: center, angle: angle)
                return ThreadCurve(curve: curve, crossing: $0.crossing, startAt: $0.startAt, finishAt: $0.finishAt)
            }
        }
    }

    struct InverseThreadCrossing: DrawgramBuildingCommand {
        let name: String

        func execute(in context: inout DrawgramBuildingContext) {
            let midLayer = CurveCrossing.middle.layer
            context.transform(name: name) {
                let crossingLayer = 2 * midLayer - $0.crossing.layer
                let crossing = CurveCrossing.custom(crossingLayer)
                return ThreadCurve(curve: $0.curve, crossing: crossing, startAt: $0.startAt, finishAt: $0.finishAt)
            }
        }
    }
}

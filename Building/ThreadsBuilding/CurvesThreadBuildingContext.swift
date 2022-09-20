//
//  CurvesThreadBuildingContext.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 15.09.2022.
//

import Foundation

class CurvesThreadBuildingContext {
    var name: String = UUID().uuidString
    var curves: [ThreadCurve] = []
    private var bundleStartAt: CGFloat = 0
    private var currentBundle: [ThreadCurve] = []

    var lastCurve: BezierCurve? {
        return currentBundle.last?.curve ?? curves.last?.curve
    }

    var allCurves: [ThreadCurve] {
        var allCurves = [ThreadCurve]()
        allCurves.append(contentsOf: curves)
        allCurves.append(contentsOf: currentBundle)
        return allCurves
    }

    func setName(_ name: String) {
        self.name = name
    }

    func start(from curve: BezierCurve) {
        guard curves.isEmpty else {
            fatalError("Thread not empty")
        }
        addCurve(curve)
    }

    func addCurve(_ curve: BezierCurve, crossing: CurveCrossing = .middle) {
        currentBundle.append(.init(curve: curve, crossing: crossing))
    }

    func addLine(from: CGPoint, to: CGPoint) {
        addCurve(.line(from: from, to: to))
    }

    func continueLine(to: CGPoint) {
        guard let lastPoint = lastCurve?.p3 else {
            fatalError("Try to continue thread, which not started")
        }
        let curve = BezierCurve.line(from: lastPoint, to: to)
        addCurve(curve)
    }

    func continueCurve(to: CGPoint, c1: CGPoint, c2: CGPoint) {
        guard let lastPoint = lastCurve?.p3 else {
            fatalError("Try to continue thread, which not started")
        }
        let curve = BezierCurve(points: [lastPoint, c1, c2, to])
        addCurve(curve)
    }

    func addTimestamp(_ timestamp: CGFloat) {
        finalizeBundle(finishAt: timestamp)
    }

    func addSelfMirroredCurves(reversion: Bool) {
        let mirrored = allCurves.map { threadCurve in
            threadCurve.transformed {
                reversion ? $0.mirrored().reversed() : $0.mirrored()
            }
        }
        currentBundle.append(contentsOf: mirrored)
    }

    func addMirroredCurves(center: CGPoint = .zero) {
        let mirrored = allCurves.map { threadCurve in
            threadCurve.transformed { $0.mirrored(by: center) }
        }
        currentBundle.append(contentsOf: mirrored)
    }

    func addRotatedCurves(amount: Int?, center: CGPoint = .zero, angle: CGFloat) {
        let source = allCurves.suffix(amount ?? allCurves.count)
        let rotated = source.map { threadCurve in
            threadCurve.transformed { $0.rotated(center: center, angle: angle) }
        }
        currentBundle.append(contentsOf: rotated)
    }

    func applyCrossings(_ crossings: [CurveCrossing]){
        guard let curve = currentBundle.last?.curve else {
            fatalError("Try to apply crossing to thread, which not started or after Timestamp. Crossing should be applied before timestamp.")
        }
        guard curve.isLine() else {
            fatalError("Crossing may be applied only at lines")
        }

        currentBundle.removeLast()
        let segment = LineSegment(from: curve.p0, to: curve.p3)
        for i in 0..<crossings.count {
            let from = CGFloat(i) / CGFloat(crossings.count)
            let to = CGFloat(i + 1) / CGFloat(crossings.count)
            let cutted = segment.subsegment(from: from, to: to)
            let curve = ThreadCurve(curve: cutted.toCurve(), crossing: crossings[i])
            currentBundle.append(curve)
        }

    }

    func finalize() {
        guard !currentBundle.isEmpty else { return }
        finalizeBundle(finishAt: 1)
    }

    private func finalizeBundle(finishAt: CGFloat) {
        let duration = finishAt - bundleStartAt
        let lengths = currentBundle.map { $0.curve.length() }
        let total = lengths.reduce(0, +)

        var timestamp = bundleStartAt
        for i in 0..<currentBundle.count {
            let bundleCurve = currentBundle[i]
            let finishAt = timestamp + duration * lengths[i] / total
            let filled = ThreadCurve(curve: bundleCurve.curve, crossing: bundleCurve.crossing, startAt: timestamp, finishAt: finishAt)
            curves.append(filled)
            timestamp = finishAt
        }

        bundleStartAt = finishAt
        currentBundle = []
    }
}

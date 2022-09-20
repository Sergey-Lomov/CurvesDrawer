//
//  DrawgramBuildingContext.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 13.09.2022.
//

import Foundation

class DrawgramBuildingContext {
    var rawCurves: [DrawableCurve] = []
    var threads: [CurvesThread] = []

    func addRawCurve(_ curve: DrawableCurve) {
        rawCurves.append(curve)
    }

    func addThread(_ thread: CurvesThread) {
        threads.append(thread)
    }

    func transform(name: String, transform: (ThreadCurve) -> ThreadCurve) {
        guard var thread = threads.first(where: { $0.name == name }) else {
            fatalError("Can't find thread with name \(name)")
        }
        for i in 0..<thread.curves.count {
            thread.curves[i] = transform(thread.curves[i])
        }
    }

    func addTransformed(source: String, name: String, transform: (ThreadCurve) -> ThreadCurve) {
        guard let thread = threads.first(where: { $0.name == source }) else {
            fatalError("Can't find thread with name \(source)")
        }

        let transformedCurves = thread.curves.map { transform($0) }
        let transformed = CurvesThread(name: name, curves: transformedCurves)
        threads.append(transformed)
    }
}

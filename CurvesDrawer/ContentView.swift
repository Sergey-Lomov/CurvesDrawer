//
//  ContentView.swift
//  CurvesDrawer
//
//  Created by serhii.lomov on 11.09.2022.
//

import SwiftUI

struct ContentView: View {

    private let strokeStyle = StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
    private let backColor = Color(red: 0.75, green: 0.67, blue: 0.88)
    private let strokeColor = Color(red: 0.6, green: 0.25, blue: 0.6)
    private let duration = 5.0

    @State private var progress: DrawingProgress = .zero

    var body: some View {
        let opacity: CGFloat = progress == .zero ? 0 : 1
        CenteredGeometryReader {
            backColor
                .ignoresSafeArea(.all)
            DrawableCurvesView(elements: curves, undercolor: backColor)
                .opacity(opacity)
                .animation(nil, value: opacity)
                .drawingProgress(progress)
                .environment(\.drawingWidth, 25)
                .animation(.linear(duration: duration), value: progress)
                .foregroundColor(strokeColor)
                .aspectRatio(1, contentMode: .fit)
                .padding(50)
        }
        .onTapGesture {
            progress = .full
        }
    }

    private var curves: [DrawableCurve] {
        let cornerRadius = 0.25
        let centerRadius = 0.4
        let cornerOffset = 0.5 - cornerRadius / 2

        let segment1_1 = BezierCurve
            .arc(from: .pi * 0.75, to: .pi * -0.25, radius: 0.5)
            .scaled(x: cornerRadius, y: cornerRadius)
            .translated(x: cornerOffset, y: -1 * cornerOffset)
            .smoothed(mult1: 1.5, mult2: 1.5)
        let segment1_3 = segment1_1
            .mirrored(by: .zero)
        let segment1_2_1 = LineSegment(from: segment1_1.p3, to: segment1_3.p0)
            .subsegment(from: 0, to: 0.5)
            .toCurve()
        let segment1_2_2 = LineSegment(from: segment1_1.p3, to: segment1_3.p0)
            .subsegment(from: 0.5, to: 1)
            .toCurve()
        let segment1_4_1 = LineSegment(from: segment1_3.p3, to: segment1_1.p0)
            .subsegment(from: 0, to: 0.5)
            .toCurve()
        let segment1_4_2 = LineSegment(from: segment1_3.p3, to: segment1_1.p0)
            .subsegment(from: 0.5, to: 1)
            .toCurve()

        let drawable1_1 = DrawableCurve(curve: segment1_1, startAt: 0, finishAt: 0.25)
            .timeScaled(0.5)
        let drawable1_2_1 = DrawableCurve(curve: segment1_2_1, startAt: 0.25, finishAt: 0.375)
            .timeScaled(0.5)
        let drawable1_2_2 = DrawableCurve(curve: segment1_2_2, startAt: 0.375, finishAt: 0.5)
            .timeScaled(0.5)
        let drawable1_3 = DrawableCurve(curve: segment1_3, startAt: 0.5, finishAt: 0.75)
            .timeScaled(0.5)
        let drawable1_4_1 = DrawableCurve(curve: segment1_4_1, startAt: 0.75, finishAt: 0.875)
            .timeScaled(0.5)
        let drawable1_4_2 = DrawableCurve(curve: segment1_4_2, startAt: 0.875, finishAt: 1)
            .timeScaled(0.5)

        let segment2_1 = BezierCurve
            .arc(from: .pi * 1.25, to: .pi * 0.25, radius: 0.5)
            .scaled(x: cornerRadius, y: cornerRadius)
            .translated(x: -1 * cornerOffset, y: -1 * cornerOffset)
            .smoothed(mult1: 1.5, mult2: 1.5)
        let segment2_3 = segment2_1
            .mirrored()
            .reversed()
            .translated(x: cornerOffset * 2, y: cornerOffset * 2)
        let segment2_2 = BezierCurve
            .line(from: segment2_1.p3, to: segment2_3.p0)
        let segment2_4 = BezierCurve
            .line(from: segment2_3.p3, to: segment2_1.p0)

        let drawable2_1 = DrawableCurve(curve: segment2_1, startAt: 0, finishAt: 0.25)
            .timeScaled(0.5)
        let drawable2_2 = DrawableCurve(curve: segment2_2, startAt: 0.25, finishAt: 0.5)
            .timeScaled(0.5)
        let drawable2_3 = DrawableCurve(curve: segment2_3, startAt: 0.5, finishAt: 0.75)
            .timeScaled(0.5)
        let drawable2_4 = DrawableCurve(curve: segment2_4, startAt: 0.75, finishAt: 1)
            .timeScaled(0.5)

        let segment3_1 = BezierCurve
            .arc(from: .pi * 0.75, to: .pi * 0.25, radius: 0.5)
            .scaled(x: centerRadius, y: centerRadius)
            .translated(x: 0, y: -1 * (0.5 - centerRadius / 2))
        let segment3_3 = segment3_1.rotated(angle: -1 * .hpi)
        let segment3_5 = segment3_3.rotated(angle: -1 * .hpi)
        let segment3_7 = segment3_5.rotated(angle: -1 * .hpi)
        let segment3_2_1 = LineSegment(from: segment3_1.p3, to: segment3_3.p0)
            .subsegment(from: 0, to: 0.5)
            .toCurve()
        let segment3_2_2 = LineSegment(from: segment3_1.p3, to: segment3_3.p0)
            .subsegment(from: 0.5, to: 1)
            .toCurve()
        let segment3_4_1 = LineSegment(from: segment3_3.p3, to: segment3_5.p0)
            .subsegment(from: 0, to: 0.5)
            .toCurve()
        let segment3_4_2 = LineSegment(from: segment3_3.p3, to: segment3_5.p0)
            .subsegment(from: 0.5, to: 1)
            .toCurve()
        let segment3_6_1 = LineSegment(from: segment3_5.p3, to: segment3_7.p0)
            .subsegment(from: 0, to: 0.5)
            .toCurve()
        let segment3_6_2 = LineSegment(from: segment3_5.p3, to: segment3_7.p0)
            .subsegment(from: 0.5, to: 1)
            .toCurve()
        let segment3_8_1 = LineSegment(from: segment3_7.p3, to: segment3_1.p0)
            .subsegment(from: 0, to: 0.5)
            .toCurve()
        let segment3_8_2 = LineSegment(from: segment3_7.p3, to: segment3_1.p0)
            .subsegment(from: 0.5, to: 1)
            .toCurve()

        let drawable3_1 = DrawableCurve(curve: segment3_1, startAt: 0, finishAt: 0.100)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_2_1 = DrawableCurve(curve: segment3_2_1, startAt: 0.100, finishAt: 0.175)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_2_2 = DrawableCurve(curve: segment3_2_2, startAt: 0.175, finishAt: 0.250)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_3 = DrawableCurve(curve: segment3_3, startAt: 0.250, finishAt: 0.350)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_4_1 = DrawableCurve(curve: segment3_4_1, startAt: 0.350, finishAt: 0.425)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_4_2 = DrawableCurve(curve: segment3_4_2, startAt: 0.425, finishAt: 0.500)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_5 = DrawableCurve(curve: segment3_5, startAt: 0.500, finishAt: 0.600)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_6_1 = DrawableCurve(curve: segment3_6_1, startAt: 0.600, finishAt: 0.675)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_6_2 = DrawableCurve(curve: segment3_6_2, startAt: 0.675, finishAt: 0.750)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_7 = DrawableCurve(curve: segment3_7, startAt: 0.750, finishAt: 0.850)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_8_1 = DrawableCurve(curve: segment3_8_1, startAt: 0.850, finishAt: 0.925)
            .timeScaled(0.5).timeTranslated(0.5)
        let drawable3_8_2 = DrawableCurve(curve: segment3_8_2, startAt: 0.925, finishAt: 1.0)
            .timeScaled(0.5).timeTranslated(0.5)

        return [drawable3_1, drawable3_2_1, drawable3_3, drawable3_4_1,
                drawable3_5, drawable3_6_1, drawable3_7, drawable3_8_1,
                drawable1_1, drawable1_2_2, drawable1_3, drawable1_4_2,
                drawable2_1, drawable2_2, drawable2_3, drawable2_4,
                drawable1_2_1, drawable1_4_1,
                drawable3_2_2, drawable3_4_2, drawable3_6_2, drawable3_8_2,]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

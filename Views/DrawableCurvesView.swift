//
//  DrawableCurvesView.swift
//  TIA
//
//  Created by serhii.lomov on 11.06.2022.
//

import SwiftUI

struct DrawableCurvesView: View {

    private let understrokeMult: CGFloat = 1.2
    private let understrokeBorder: CGFloat = 0.15

    let elements: [DrawableCurve]
    var lineCap: CGLineCap = .round
    var undercolor: Color = .clear
    @Environment(\.drawingProgress) var drawingProgress
    @Environment(\.drawingWidth) var drawingWidth

    var body: some View {
        CenteredGeometryReader { geometry in
            ForEach(elements, id: \.id) { element in
//                ForEach(element.understrokes, id: \.self) { understroke in
//                    let finish = min(understroke.from, relativeProgress(element))
//                    Path(curve: element.curve, geometry: geometry)
//                        .trimmedPath(from: understroke.0, to: finish)
//                        .stroke(style: understrokeStyle(element))
//                }.foregroundColor(undercolor)

                Path(curve: element.curve, geometry: geometry)
                    .trimmedPath(from: understrokeBorder, to: undestrokeProgress(element))
                    .stroke(style: understrokeStyle(element))
                    .foregroundColor(undercolor)

                Path(curve: element.curve, geometry: geometry)
                    .trimmedPath(from: 0, to: relativeProgress(element))
                    .stroke(style: strokeStyle(element))
                    .animation(nil, value: relativeProgress(element))
            }
        }
    }

    private func relativeProgress(_ element: DrawableCurve) -> CGFloat {
        let length = element.finishAt - element.startAt
        let relative = (drawingProgress.value - element.startAt) / length
        return relative.normalized(min: 0, max: 1)
    }

    private func undestrokeProgress(_ element: DrawableCurve) -> CGFloat {
        return min(relativeProgress(element), 1 - understrokeBorder)
    }

    private func strokeStyle(_ element: DrawableCurve) -> StrokeStyle {
        let width = element.widthMult * drawingWidth
        return StrokeStyle(lineWidth: width, lineCap: lineCap)
    }

    private func understrokeStyle(_ element: DrawableCurve) -> StrokeStyle {
        let width = element.widthMult * drawingWidth * understrokeMult
        return StrokeStyle(lineWidth: width, lineCap: .butt)
    }
}

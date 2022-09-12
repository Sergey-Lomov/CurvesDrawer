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
    private let duration = 4.0

    @State private var progress: DrawingProgress = .zero

    var body: some View {
        let opacity: CGFloat = progress == .zero ? 0 : 1
        CenteredGeometryReader {
            backColor
                .ignoresSafeArea(.all)
            DrawableCurvesView(elements: curves)
                .opacity(opacity)
                .animation(nil, value: opacity)
                .drawingProgress(progress)
                .environment(\.drawingWidth, 4)
                .animation(.linear(duration: 4), value: progress)
                .foregroundColor(strokeColor)
                .aspectRatio(1, contentMode: .fit)
                .padding()
        }
        .onTapGesture {
            progress = .full
        }
    }

    private var curves: [DrawableCurve] {
        let curve = BezierCurve(x0: -0.5, y0: -0.5, x1: -0.5, y1: 0.5, x2: 0.5, y2: -0.5, x3: 0.5, y3: 0.5)
        let drawable = DrawableCurve(curve: curve, startAt: 0, finishAt: 1)
        return [drawable]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

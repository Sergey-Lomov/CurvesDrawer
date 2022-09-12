//
//  View.swift
//  TIA
//
//  Created by Serhii.Lomov on 10.04.2022.
//

import SwiftUI

extension View {

    func frame(geometry: GeometryProxy) -> some View {
        frame(size: geometry.size)
    }

    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }

    func frame(size: CGFloat) -> some View {
        frame(width: size, height: size)
    }

    func offset(point: CGPoint) -> some View {
        return offset(x: point.x, y: point.y)
    }

    func offset(point: CGPoint, geometry: GeometryProxy) -> some View {
        let scaled = point.scaled(geometry)
        return offset(x: scaled.x, y: scaled.y)
    }

    func offset(_ point: CGPoint, geomtery: GeometryProxy) -> some View {
        let x = point.x * geomtery.size.width
        let y = point.y * geomtery.size.height
        return offset(x: x, y: y)
    }

    func drawingProgress(_ value: DrawingProgress) -> some View {
        modifier(DrawingProgressModifier(drawingProgress: value))
    }
}

//
//  Starfield.swift
//  Cosmic
//
//  Created by Mario Guerrieri on 12/31/24.
//

import SwiftUI

infix operator /

private extension CGPoint {
    init(size: CGSize) { self.init(x: size.width, y: size.height) }

    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return .init(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    static var randomNormalized: CGPoint {
        .init(x: CGFloat.random(in: 0...1), y: .random(in: 0...1))
    }
}

private extension CGSize {
    init(point: CGPoint) { self.init(width: point.x, height: point.y) }

    static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return .init(width: lhs.width / rhs,
                     height: lhs.height / rhs)
    }
    static func * (lhs: CGSize, rhs: CGPoint) -> CGSize {
        return .init(width: lhs.width * rhs.x,
                     height: lhs.height * rhs.y)
    }
}

private extension CGRect {
    init(size: CGSize) { self.init(origin: .zero, size: size) }

    var leftTopCorner: CGPoint { .init(x: minX, y: minY) }
    var leftEdgeMidPoint: CGPoint { .init(x: minX, y: midY) }
    var leftBottomCorner: CGPoint { .init(x: minX, y: maxY) }

    var topEdgeMidPoint: CGPoint { .init(x: midX, y: minY) }
    var center: CGPoint { .init(x: midX, y: midY) }
    var bottomEdgeMidPoint: CGPoint { .init(x: midX, y: maxY) }

    var rightTopCorner: CGPoint { .init(x: maxX, y: minY) }
    var rightEdgeMidPoint: CGPoint { .init(x: maxX, y: midY) }
    var rightBottomCorner: CGPoint { .init(x: maxX, y: maxY) }
}

private struct Star: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let bounds = CGRect(size: geometry.size)
                path.move(to: bounds.leftEdgeMidPoint)
                path.addCurve(to: bounds.topEdgeMidPoint,
                              control1: bounds.center,
                              control2: bounds.center)
                path.addCurve(to: bounds.rightEdgeMidPoint,
                              control1: bounds.center,
                              control2: bounds.center)
                path.addCurve(to: bounds.bottomEdgeMidPoint,
                              control1: bounds.center,
                              control2: bounds.center)
                path.addCurve(to: bounds.leftEdgeMidPoint,
                              control1: bounds.center,
                              control2: bounds.center)
            }
            .fill()
        }
    }
}

private struct TwinklyStar: View {
    @State private var opacity: Double = 0.3

    let twinkDuration: Double

    var body: some View {
        Star()
            .opacity(opacity)
            .onAppear {
                withAnimation(.bouncy(duration: twinkDuration).repeatForever()) {
                    opacity = 1
                }
            }
    }
}

struct Starfield: View {
    private struct StarState: Identifiable {
        let id: Int

        let position: CGPoint
        let twinkDuration = Double.random(in: 0.5...1.5)
    }

    @State private var stars: [StarState]

    init(count: Int = 100) {
        self.stars = (0..<count).map {
            StarState(id: $0, position: .randomNormalized)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(stars) { star in
                TwinklyStar(twinkDuration: star.twinkDuration)
                    .frame(width: 15, height: 15)
                    .position(.init(size: geometry.size * star.position))
            }
        }
    }
}

#Preview {
    Starfield()
}

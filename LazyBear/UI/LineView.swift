//
//  LineView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/3/21.
//

import SwiftUI

struct LineView: View {
    var width: CGFloat
    var height: CGFloat
    var normalizedData: [Double]
    
    // Drag gesture
    @State private var touchLocation: CGPoint = .zero

    var body: some View {
        Line(width: width, height: height, normalizedData: normalizedData)
            .stroke(Color.green, lineWidth: 2)
            .rotationEffect(.degrees(180), anchor: .center)  // The path must be rotated
            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
            .gesture(DragGesture()  // Add gesture
            .onChanged({ value in  // Take value of the gesture
                print("Location - > \(value.location)")
            })
        )
    }
}

struct Line: Shape {
    var width: CGFloat
    var height: CGFloat
    var normalizedData: [Double]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Substract 2 to skip the first and the last item
        let widthBetweenPoints = Double(width) / Double(normalizedData.count - 2)
        let initialPoint = normalizedData[0] * Double(height)
        var x: Double = 0
        
        path.move(to: CGPoint(x: x, y: initialPoint))
        for y in normalizedData {
            // Skip first item
            if normalizedData.firstIndex(of: y) != 0 {
                x += widthBetweenPoints
                let y = y * Double(height)
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            VStack {
                let normalizedData: [Double] = [0, 0.1, 0.15, 0.2, 0.3, 0.4, 0.35, 0.38, 0.5, 0.55, 0.6, 0.57, 0.8, 1]
                LineView(width: geo.size.width, height: geo.size.width / 2, normalizedData: normalizedData)
            }
        }
    }
}

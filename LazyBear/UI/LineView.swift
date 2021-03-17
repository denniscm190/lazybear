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
        // Substract 2 to skip the first and the last item
        let widthBetweenPoints = Double(width) / Double(normalizedData.count - 2)
        let initialPoint = normalizedData[0] * Double(height)
        var x: Double = 0
        var pathPoints = [CGPoint]()
        
        ZStack {
            GeometryReader { geo in
            Path { path in
                path.move(to: CGPoint(x: x, y: initialPoint))
                for y in normalizedData {
                    // Skip first item
                    if normalizedData.firstIndex(of: y) != 0 {
                        x += widthBetweenPoints
                        let y = y * Double(height)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    
                    pathPoints.append(path.currentPoint!)
                }
            }
            .stroke(Color.green, lineWidth: 2)
            .gesture(DragGesture()  // Add gesture
            .onChanged({ value in  // Take value of the gesture
                let (closestXPoint, closestYPoint) = getClosestValueFrom(value.location, inData: pathPoints)
                self.touchLocation.x = closestXPoint
                self.touchLocation.y = closestYPoint
                
            }))
            
            
            IndicatorPoint()
                .position(x: touchLocation.x, y: touchLocation.y)
            }
        }
    }
    
    // First search the closest X path point from the touch location. The find the correspondant Y path point
    // given the X path point
    func getClosestValueFrom(_ value: CGPoint, inData: [CGPoint]) -> (CGFloat, CGFloat) {
        let touchPoint: (CGFloat, CGFloat) = (value.x, value.y)
        let xPathPoints = inData.map { $0.x }
        let yPathPoints = inData.map { $0.y }
        
        // Closest X value
        let closestXPoint = xPathPoints.enumerated().min( by: { abs($0.1 - touchPoint.0) < abs($1.1 - touchPoint.0) } )!
        let closestYPointIndex = xPathPoints.firstIndex(of: closestXPoint.element)!
        let closestYPoint = yPathPoints[closestYPointIndex]
        
        return (closestXPoint.element, closestYPoint)
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

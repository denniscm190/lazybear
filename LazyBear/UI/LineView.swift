//
//  LineView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 15/3/21.
//

import SwiftUI

struct LineView: View {
    var colour: Color
    var width: CGFloat
    var height: CGFloat
    var normalizedData: [Double]
    let haptics = Haptics()
    
    // Drag gesture
    @Binding var showingChartIndicator: Bool
    @Binding var pointInPath: CGPoint
    @Binding var indexValue: Int
    
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>

    var body: some View {
        let colour = Color("\(userSettings.first?.theme?.lowercased() ?? "default")Accent")
        
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
                .stroke(self.showingChartIndicator ? colour: self.colour, lineWidth: 2)
                
                if showingChartIndicator {
                    IndicatorPoint()
                        .position(x: pointInPath.x, y: pointInPath.y)
                    }
            }
        }
        .contentShape(Rectangle())  // Control tappable area
        .gesture(
            LongPressGesture(minimumDuration: 0.2)
                .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
        .onChanged({ value in  // Take value of the gesture
            switch value {
            // Start the second gesture -> Drag()
            case .second(true, let drag):
                if let longPressLocation = drag?.location {
                    let (closestXPoint, closestYPoint, yPointIndex) = getClosestValueFrom(longPressLocation, inData: pathPoints)
                    self.pointInPath.x = closestXPoint
                    self.pointInPath.y = closestYPoint
                    self.showingChartIndicator = true
                    self.indexValue = yPointIndex
                } else {
                    haptics.simpleSuccess()
                }
            default:
                break
            }
        })
                .onEnded({ value in
                    self.showingChartIndicator = false
                })
        )
    }
    
    // First search the closest X path point from the touch location. The find the correspondant Y path point
    // given the X path point
    func getClosestValueFrom(_ value: CGPoint, inData: [CGPoint]) -> (CGFloat, CGFloat, Int) {
        let touchPoint: (CGFloat, CGFloat) = (value.x, value.y)
        let xPathPoints = inData.map { $0.x }
        let yPathPoints = inData.map { $0.y }
        
        // Closest X value
        let closestXPoint = xPathPoints.enumerated().min( by: { abs($0.1 - touchPoint.0) < abs($1.1 - touchPoint.0) } )!
        let closestYPointIndex = xPathPoints.firstIndex(of: closestXPoint.element)!
        let closestYPoint = yPathPoints[closestYPointIndex]
        
        // Index of the closest points in the array
        let yPointIndex = yPathPoints.firstIndex(of: closestYPoint)!

        return (closestXPoint.element, closestYPoint, yPointIndex)
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            VStack {
                let normalizedData: [Double] = [0, 0.1, 0.15, 0.2, 0.3, 0.4, 0.35, 0.38, 0.5, 0.55, 0.6, 0.57, 0.8, 1]
                LineView(colour: Color(.systemGreen), width: geo.size.width, height: geo.size.width / 2, normalizedData: normalizedData, showingChartIndicator: .constant(false), pointInPath: .constant(.zero), indexValue: .constant(0))
            }
        }
    }
}

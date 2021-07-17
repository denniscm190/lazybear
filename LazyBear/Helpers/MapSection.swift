//
//  MapSection.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import MapKit

struct MapSection: View {
    var state: String
    
    var body: some View {
        let states: [UsStatesModel] = parseJson("UsStatesCoordinates.json")
        let stateObject = states.first(where: { $0.state == state })
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: stateObject?.latitude ?? 40.741895, longitude: stateObject?.longitude ?? -73.989308), span: MKCoordinateSpan(latitudeDelta: 3.5, longitudeDelta: 3.5))
        
        Map(coordinateRegion: .constant(region))
            .frame(height: 350)
    }
    
    // MARK: - PARSE JSON
    private func parseJson<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}

struct MapSection_Previews: PreviewProvider {
    static var previews: some View {
        MapSection(state: "California")
    }
}

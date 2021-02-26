//
//  IconRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct IconRow: View {
    var icon: IconModel
    
    var body: some View {
        Button(action: { changeIcon(key: icon.file) }) {
            HStack {
                Image(icon.file)
                    .resizable()
                    .frame(width: 70, height: 70)
                    
                Text(icon.name)
                Spacer()
                
                if UIApplication.shared.alternateIconName ?? "defaultIcon" == icon.file {
                    Text("Selected")
                }
            }
        }
    }
    
    private func changeIcon(key: String) {
        if key != "defaultIcon" {
            UIApplication.shared.setAlternateIconName(key) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success!")
                }
            }
        } else {
            UIApplication.shared.setAlternateIconName(nil)
        }
    }
}

struct IconRow_Previews: PreviewProvider {
    static var previews: some View {
        IconRow(icon: icons[0])
    }
}

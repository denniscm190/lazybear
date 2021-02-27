//
//  IconPicker.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/2/21.
//

import SwiftUI

struct IconPicker: View {
    var body: some View {
        List(icons, id:\.name) { icon in
            Button(action: { changeIcon(key: icon.file) }) {
                HStack {
                    Image(icon.file)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 70, height: 70)
                        
                    Text(icon.name)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .listStyle(GroupedListStyle())
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

struct IconPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IconPicker()
            
        }
    }
}

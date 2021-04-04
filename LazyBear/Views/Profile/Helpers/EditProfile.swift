//
//  EditProfile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/4/21.
//

import SwiftUI

struct EditProfile: View {
    var body: some View {
        NavigationView {
            Form {
                let footer = "This could be your first name or nickname. Let you creativity flow."
                Section(header: Text("Name"), footer: Text(footer)) {
                    Text("Hello")
                }
                
                Section(header: Text("Country")) {
                    Text("Country")
                }
            }
            .navigationTitle("Edit your profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

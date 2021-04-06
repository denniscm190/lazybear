//
//  ProfileView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/4/21.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileData = ProfileData()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(profileData.companies, id: \.self) { company in
                    Text("Hello company")
                }
            }
            .navigationTitle("My profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

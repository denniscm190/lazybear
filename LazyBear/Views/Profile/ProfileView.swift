//
//  ProfileView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/4/21.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profile = Profile()

    var body: some View {
        NavigationView {
            List {
                

            }
            .navigationTitle("My profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                profile.request("https://api.lazybear.app/profile/type=init/symbols=aapl,fb")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

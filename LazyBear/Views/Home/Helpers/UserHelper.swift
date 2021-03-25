//
//  UserHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/3/21.
//

import SwiftUI

struct UserHelper: View {
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: []) var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                UserImage()
                    .frame(height: geo.size.height * 0.15)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    let name = userSettings.first!.username
                    Text("Hello, \(name)")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("How is the market doing today?")
                        .opacity(0.5)
                }
            }
        }
    }
}

struct UserImage: View {
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: []) var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        let avatar = userSettings.first!.avatar
        Image(avatar)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10)
            .padding(5)
            
    }
}

struct UserHelper_Previews: PreviewProvider {
    static var previews: some View {
        UserHelper()
    }
}

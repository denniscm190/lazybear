//
//  AvatarCreator.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/3/21.
//

import SwiftUI

enum AvatarComponent {
    case hair, eyes, nose, mouth, body
}

struct AvatarCreator: View {
    var components = ["Hair", "Eyes", "Nose", "Mouth", "Body"]
    @State private var selectedComponent = "Hair"
    
    var body: some View {
        NavigationView {
            VStack {
                Avatar(scaleMultipler: 2, backgroundHeight: 200)
                    .padding(.top)
                
                Picker("Please choose a color", selection: $selectedComponent) {
                    ForEach(components, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Divider()
                ScrollView {
//                    if selectedComponent == "Hair" { showAvatar(component: .hair) }
//                    if selectedComponent == "Eyes" { showAvatar(component: .eyes) }
//                    if selectedComponent == "Nose" { showAvatar(component: .nose) }
//                    if selectedComponent == "Mouth" { showAvatar(component: .mouth) }
//                    if selectedComponent == "Body" { showAvatar(component: .body) }
                }
            }
            .navigationTitle("Create your avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {  }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {  }) {
                        Text("Done")
                    }
                }
            }
        }
    }
    
//    private func showAvatar(component: AvatarComponent) -> AnyView {
//        switch component {
//        case .hair:
//            return AnyView(HairView())
//        case .eyes:
//            return AnyView(EyesView())
//        case .nose:
//            return AnyView(NoseView())
//        case .mouth:
//            return AnyView(MouthView())
//        case .body:
//            return AnyView(BodyView())
//        }
//    }
}

struct AvatarCreator_Previews: PreviewProvider {
    static var previews: some View {
        AvatarCreator()
            .environmentObject(EnvironmentSignUp())
    }
}

struct ComponentView: View {
    var showColors: Bool
    var numberOfColors: Int?
    var numberOfItems: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach((1..<8)) { index in
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("hairColor\(index)"))

                }
            }
            .padding(.leading)
        }
    }
}

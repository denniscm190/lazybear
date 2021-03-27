//
//  AvatarCreator.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/3/21.
//

import SwiftUI

enum AvatarComponent {
    case hair, eyes, mouth, body
}

struct AvatarCreator: View {
    var components = ["Hair", "Eyes", "Mouth", "Body"]
    @State private var selectedComponent = "Hair"
    @Environment(\.presentationMode) var avatarGeneratorPresentation
    
    var body: some View {
        NavigationView {
            VStack {
                Avatar()
                    .padding(.top)
                
                Picker("Select a component", selection: $selectedComponent) {
                    ForEach(components, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Divider()
                ScrollView {
                    if selectedComponent == "Hair" { showAvatar(component: .hair) }
                    if selectedComponent == "Eyes" { showAvatar(component: .eyes) }
                    if selectedComponent == "Mouth" { showAvatar(component: .mouth) }
                    if selectedComponent == "Body" { showAvatar(component: .body) }
                }
            }
            .navigationTitle("Create your avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { avatarGeneratorPresentation.wrappedValue.dismiss() }) {
                        Text("Done")
                    }
                }
            }
        }
    }
    
    private func showAvatar(component: AvatarComponent) -> AnyView {
        switch component {
        case .hair:
            return AnyView(ComponentView(component: .hair))
        case .eyes:
            return AnyView(ComponentView(component: .eyes))
        case .mouth:
            return AnyView(ComponentView(component: .mouth))
        case .body:
            return AnyView(ComponentView(component: .body))
        }
    }
}

struct AvatarCreator_Previews: PreviewProvider {
    static var previews: some View {
        AvatarCreator()
            .environmentObject(FirstAvatar())
    }
}

struct ComponentView: View {
    @EnvironmentObject var firstAvatar: FirstAvatar
    @EnvironmentObject var hapticsManager: HapticsManager
    var component: AvatarComponent
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        let (componentName, maxColors, maxComponents) = getComponentInfo()
        VStack {
            // COLOR SELECTOR
            if maxColors != nil {
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        HStack(spacing: 20) {
                            ForEach((1..<maxColors!)) { index in
                                Button(action: {
                                    assignSelection(componentName: "\(componentName)Color", index: index, isColor: true)
                                    self.hapticsManager.complexSuccess()
                                }) {
                                    ColorItem(component: component, componentName: componentName, index: index)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
            
            // COMPONENT SELECTOR
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach((1..<maxComponents)) { index in
                    Button(action: {
                        assignSelection(componentName: componentName, index: index, isColor: false)
                        self.hapticsManager.complexSuccess()
                    }) {
                        ComponentItem(component: component, componentName: componentName, index: index)
                    }
                }
            }
        }
    }
    
    // If I need to add more items, I'll need to make this better. Maybe reading directly
    // a JSON file instead of manually write down the number of items and names
    private func getComponentInfo() -> (String, Int?, Int) {
        switch component {
        case .body:
            let componentName = "body"
            let maxColors = 8
            let maxComponents = 4
            return (componentName, maxColors, maxComponents)
        case .eyes:
            let componentName = "eyes"
            let maxComponents = 6
            return (componentName, nil, maxComponents)
        case .hair:
            let componentName = "hair"
            let maxColors = 8
            let maxComponents = 20
            return (componentName, maxColors, maxComponents)
        case .mouth:
            let componentName = "mouth"
            let maxComponents = 6
            return (componentName, nil, maxComponents)
        }
    }
    
    private func assignSelection(componentName: String, index: Int, isColor: Bool) {
        switch component {
        case .body:
            if isColor {
                let colorName = "customColor\(index)"
                self.firstAvatar.bodyColor = colorName
            }
            else {
                self.firstAvatar.body = "\(componentName)\(index)"
            }
        case .eyes:
            self.firstAvatar.eyes = "\(componentName)\(index)"
        case .hair:
            if isColor {
                self.firstAvatar.hairColor = "\(componentName)\(index)"
            } else {
                self.firstAvatar.hair = "\(componentName)\(index)"
            }
        case .mouth:
            self.firstAvatar.mouth = "\(componentName)\(index)"
        }
    }
}

struct ColorItem: View {
    @EnvironmentObject var firstAvatar: FirstAvatar
    var component: AvatarComponent
    var componentName: String
    var index: Int
    
    var body: some View {
        let componentColor = "\(componentName)Color\(index)"
        Circle()
            .frame(width: 50, height: 50)
            .foregroundColor(component == .body ? Color("customColor\(index)"): Color(componentColor))
            .padding(5)
            .background(firstAvatar.hairColor == componentColor ?
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundColor(.gray)
                :
                nil
            )
            .padding(.vertical)
    }
}

struct ComponentItem: View {
    @EnvironmentObject var firstAvatar: FirstAvatar
    var component: AvatarComponent
    var componentName: String
    var index: Int
    
    var body: some View {
        PreviewAvatar(stringComponent: "\(componentName)\(index)", component: component)
            .frame(height: 100)
            .background(checkItemSelected(componentName: "\(componentName)\(index)") ?
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                    .foregroundColor(.gray)
                :
                nil
            )
            .padding(.vertical)
    }
    
    private func checkItemSelected(componentName: String) -> Bool {
        if component == .body {
            if firstAvatar.body == componentName { return true }
        }
        else if component == .eyes {
            if firstAvatar.eyes == componentName { return true }
        }
        else if component == .hair {
            if firstAvatar.hair == componentName { return true }
        }
        else if component == .mouth {
            if firstAvatar.mouth == componentName { return true }
        }
        return false
    }
}


struct PreviewAvatar: View {
    @EnvironmentObject var firstAvatar: FirstAvatar
    var stringComponent: String
    var component: AvatarComponent
    
    var body: some View {
        Image("head")
            .componentModifier()
            .overlay(
                ZStack {
                    if component == .body {
                        Image(stringComponent)
                            .componentModifier()
                            .colorMultiply(Color(firstAvatar.bodyColor))
                    } else {
                        Image(firstAvatar.body)
                            .componentModifier()
                            .colorMultiply(Color(firstAvatar.bodyColor))
                    }
                    
                    if component == .hair {
                        Image(stringComponent)
                            .componentModifier()
                            .colorMultiply(Color(firstAvatar.hairColor))
                    } else {
                        Image(firstAvatar.hair)
                            .componentModifier()
                            .colorMultiply(Color(firstAvatar.hairColor))
                    }
                    
                    if component == .eyes {
                        Image(stringComponent)
                            .componentModifier()
                    } else {
                        Image(firstAvatar.eyes)
                            .componentModifier()
                    }
                    
                    Image(firstAvatar.nose)
                        .componentModifier()
                    
                    if component == .mouth {
                        Image(stringComponent)
                            .componentModifier()
                    } else {
                        Image(firstAvatar.mouth)
                            .componentModifier()
                    }
                }
            )
    }
}

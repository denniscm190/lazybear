//
//  RenameSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/4/21.
//

import SwiftUI

struct RenameSheet: View {
    @State private var name: String = String()
    @Binding var showAction: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 280, height: 180)
            .foregroundColor(Color(.secondarySystemBackground))
            .overlay(
                VStack {
                    Text("Rename your list")
                        .font(.headline)
                    
                    Text("Enter a name")
                        .font(.callout)
                    
                    Spacer()
                    TextField("Technologies, banks, ...", text: $name)
                        .padding(8)
                        .background(
                            Color(.systemBackground)
                                .cornerRadius(8)
                        )
                    
                    Divider()

                    HStack {
                        Spacer()
                        Button(action: {
                            UIApplication.shared.endEditing()
                            self.showAction = false
                        }) {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        

                        Spacer()
                        Divider()
                            
                        Spacer()
                        Button(action: {}) {
                            Text("Done")
                        }
                        Spacer()
                    }
                    .frame(height: 25)
                }
                .padding()
            )
        .background(
            BlurBackground(style: .systemMaterial)
               .clipShape(RoundedRectangle(cornerRadius: 20))
        )
    }
}
// Dismiss Keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct RenameSheet_Previews: PreviewProvider {
    static var previews: some View {
        RenameSheet(showAction: .constant(true))
    }
}

//
//  TextfieldAlert.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/4/21.
//

import SwiftUI

struct TextfieldAlert: View {
    var listName: String
    
    @State private var newListName: String = String()
    @Binding var showRenameAction: Bool
    @Binding var presentationMode: PresentationMode
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompany: FetchedResults<WatchlistCompany>
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 280, height: 180)
            .foregroundColor(Color(.secondarySystemBackground))
            .overlay(
                VStack {
                    Text("Rename your list")
                        .font(.headline)
                    
                    Text("Enter a name")
                        .font(.callout)
                    
                    Spacer()
                    TextField("Technologies, banks...", text: $newListName)
                        .padding(7)
                        .background(
                            Color(.systemBackground)
                                .cornerRadius(7)
                        )
                    
                    Divider()
                    
                    
                    /*
                     Cancel and Done buttons
                     */
                    HStack {
                        Spacer()
                        Button(action: {
                            UIApplication.shared.endEditing()
                            self.showRenameAction = false
                        }) {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }

                        Spacer()
                        Divider()
                            
                        Spacer()
                        Button(action: { renameList(newListName) }) {
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
               .clipShape(RoundedRectangle(cornerRadius: 15))
        )
    }
    
    /*
     Rename watchlist name in Core Data
     */
    private func renameList(_ newListName: String) {
        let selectedWatchlist = watchlistCompany.filter({ $0.watchlist == listName })
        for company in selectedWatchlist {
            company.watchlist = newListName
        }
        do {
            try moc.save()
            print("List updated")
            UIApplication.shared.endEditing()  /// Dismiss Keyboard
            self.showRenameAction = false  /// Dismiss action rename sheet
            self.$presentationMode.wrappedValue.dismiss()  /// Dismiss Modal View
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension UIApplication {  /// Dismiss Keyboard Extension
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct RenameSheet_Previews: PreviewProvider {
    @Environment(\.presentationMode) static var presentationMode
    
    static var previews: some View {
        TextfieldAlert(listName: "MyWatchlist", showRenameAction: .constant(true), presentationMode: presentationMode)
    }
}

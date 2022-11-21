//
//  Listings.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import Foundation
import SwiftUI
import CoreData

struct ListingsView: View {
    @State private var presentAlert = false
    @State private var clientName: String = ""
    @State private var clientAddress: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Listing.clientName, ascending: true)],
        animation: .default)
    private var listings: FetchedResults<Listing>

    var body: some View {
        NavigationView {
            List {
                ForEach(listings) { listing in
                    NavigationLink {
                        Text("Client name: \(listing.clientName!)")
                        Text("Client address: \(listing.clientAddress!)")
                    } label: {
                        Text(listing.clientName!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                        Button("Add") {
                        presentAlert = true
                    }
                    .alert("Add listing", isPresented: $presentAlert, actions: {
                        TextField("Client name", text: $clientName)

                        TextField("Client address", text: $clientAddress)

                        Button("Add", action: {
                            let newListing = Listing(context: viewContext)
                            newListing.clientName = clientName
                            newListing.clientAddress = clientAddress
                            do {
                                try viewContext.save()
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Enter listing details.")
                    })
                    }
            }
            Text("Select an item")
        }
    }

    // For checking simulator data location
    //print("app folder path is \(NSHomeDirectory())")
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { listings[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ListingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//
//  Listings.swift
//  DecAR
//
//  Created by iosdev on 20.11.2022.
//

import Foundation
import SwiftUI
import CoreData

let listingsClientName = NSLocalizedString("listingsClientName", comment: "listingsClientName")
let listingsClientAddress = NSLocalizedString("listingsClientAddress", comment: "listingsClientAddress")
let listingsAddBtn = NSLocalizedString("listingsAddBtn", comment: "listingsAddBtn")
let listingsAlertAddListing = NSLocalizedString("listingsAlertAddListing", comment: "listingsAlertAddListing")
let listingsClientName2 = NSLocalizedString("listingsClientName2", comment: "listingsClientName2")
let listingsClientAddress2 = NSLocalizedString("listingsClientAddress2", comment: "listingsClientAddress2")
let listingsBtnCancel = NSLocalizedString("listingsBtnCancel", comment: "listingsBtnCancel")
let listingsDetails = NSLocalizedString("listingsDetails", comment: "listingsDetails")
let listingsSelectItem = NSLocalizedString("listingsSelectItem", comment: "listingsSelectItem")

struct ListingsView: View {
    @State private var presentAlert = false
    @State private var clientName: String = ""
    @State private var clientAddress: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Listing.clientName!, ascending: true)],
        animation: .default)
    private var listings: FetchedResults<Listing>

    var body: some View {
        NavigationView {
            List {
                ForEach(listings) { listing in
                    NavigationLink {
                        Group {
                            Text("\(listing.clientName!)")
                            Text("\(listing.clientAddress!)")
                        }.lineSpacing(10).font(.system(size: 20, weight: .semibold, design: .rounded)).padding(10).overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 49/255, green: 160/255, blue: 224/255), lineWidth: 1))
                    } label: {
                        Text(listing.clientName!)
                    }
                }
                .onDelete(perform: deleteItems)
                .listRowSeparator(.hidden)
                .listRowBackground(Color(red: 234/255, green: 237/255, blue: 239/255))
                .padding(8)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                        Button(listingsAddBtn) {
                        presentAlert = true
                    }
                        .popover(isPresented: self.$presentAlert, arrowEdge: .bottom) {
                            Text(listingsAlertAddListing)
                            TextField(listingsClientName2, text: $clientName)
                            TextField(listingsClientAddress2, text: $clientAddress)
                            Button(listingsAddBtn, action: {
                                let newListing = Listing(context: viewContext)
                                newListing.clientName = clientName
                                newListing.clientAddress = clientAddress
                                do {
                                    try viewContext.save()
                                    self.presentAlert = false
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            })
                            Button(listingsBtnCancel, action: {
                                self.presentAlert = false
                            })
                        }
                
                    }
            }
                     
            Text(listingsSelectItem)
        }
    }

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
        ContentView(currentObject: .constant(SelectedFurniture("stool"))).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

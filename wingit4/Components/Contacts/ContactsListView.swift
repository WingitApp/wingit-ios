//
//  ContactsList.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Foundation
import SwiftUI

struct ContactsListView: View {
    @ObservedObject var viewModel = ContactsListViewModel()

    var body: some View {
         VStack {
            SearchBar(text: $viewModel.searchText, placeholder: "Search contacts")

            List {
                // Filtered list of names
                ForEach(viewModel.contacts.filter { viewModel.contactFilter(contact: $0)}, id:\.id) { contact in // --> We display all filtered contacts
                        NavigationLink(destination: ContactDetailView(contact: contact)) {
                            ContactItem(contact: contact)
                        }
                }
            }
//            .modifier(ResignKeyboardOnDragGesture())
        }
         .navigationTitle("Invite friends")
         .navigationBarTitleDisplayMode(.inline)
         .onAppear {
            viewModel.fetch()
         }
    }
}

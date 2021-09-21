//
//  ContactsListViewModel.swift
//  wingit4
//
//  Created Daniel Yee on 9/17/21.
//

import Foundation
import Contacts

class ContactsListViewModel: ObservableObject {
    
    @Published var newContact = CNContact()
    @Published var contacts: [Contact] = []
    @Published var showNewContact = false // --> This is for the modal
    @Published var noPermission = false // --> Also, we should display a hint when the user hasn't granted permission so they know what's going on

    @Published var searchText = "" // --> this is for searching for contacts

    func fetch() {
        Api.Contacts.getSystemContacts { (contacts, error) in
            guard error == nil else {
                self.contacts = []
                self.noPermission = true
                return
            }
            self.contacts = contacts
        }
    }

    func contactFilter(contact: Contact) -> Bool {
        if self.searchText.count == 0 {
            return true
        }

        return contact.fullName().localizedCaseInsensitiveContains(self.searchText)
    }
}

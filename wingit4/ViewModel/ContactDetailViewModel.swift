//
//  ContactDetailViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Contacts
import Foundation
import SwiftUI

class ContactDetailViewModel: ObservableObject, Identifiable {
    @Published var contact: Contact
    @Published var showEditContactView = false

    init(contact: Contact) {
        self.contact = contact
    }

    func updateContact() { // --> When the user is done editing a contact, we inform our view to update the contact to show the newly edited content, so we fetch the updated version
        let contactStore = CNContactStore.init()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]

        do {
            let updated = try contactStore.unifiedContact(withIdentifier: self.contact.systemContact!.identifier, keysToFetch: keysToFetch)
            self.contact = Contact.fromCNContact(contact: updated)
        } catch {
            print(error)
        }
    }
}

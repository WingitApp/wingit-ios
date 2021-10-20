//
//  ContactsService.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Contacts
import Foundation

class ContactsService {
    
    var contactStore: CNContactStore?

    func fetchOrRequestPermission(completionHandler: @escaping (Bool) -> Void) {
        self.contactStore = CNContactStore.init()
        self.contactStore!.requestAccess(for: .contacts) { success, error in
            if (success) {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }

    func getSystemContacts(completionHandler: @escaping ([Contact], Error?) -> Void) {
        self.fetchOrRequestPermission() { success in    // --> First, we need to make sure we have permission to fetch the contacts
            if (success) {
                do {
                    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]    // --> The keysToFetch describe which content we actually want to access. It is good practice to keep this as limited as your app allows.

                    var contacts = [CNContact]()

                    let request = CNContactFetchRequest(keysToFetch: keysToFetch)

                    try self.contactStore!.enumerateContacts(with: request) {
                        (contact, stop) in
                        contacts.append(contact)
                    }

                    func getName(_ contact: Contact) -> String {
                        return contact.firstName.count > 0 ? contact.firstName : contact.lastName    // --> essentially, this is some sugar to order the contacts, as we often want to have them already ordered and not do it inside the model
                    }

                    let formatted = contacts.compactMap({
                        // filter out all "empty" contacts
                        if ($0.phoneNumbers.count > 0 && ($0.givenName.count > 0 || $0.familyName.count > 0)) { // --> Some devices have no contacts for some reason.
                            return Contact.fromCNContact(contact: $0)
                        }

                        return nil
                    })
                            .sorted(by: { getName($0) < getName($1) }) // --> order by First Name then Last Name
                  DispatchQueue.main.async {
                    completionHandler(formatted, nil)
                  }
                } catch {
                    print("Failed to fetch contact, error: \(error)")
                    completionHandler([], NSError()) // --> as a fallback, we return an empty array but we should capture the error elsewhere
                }
            } else {
                completionHandler([], NSError())
                print("Failed to get permission to fetch contacts.")
            }
        }
    }
}

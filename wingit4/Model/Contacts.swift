//
//  Contacts.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Contacts
import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Contact {
    @ServerTimestamp var createdAt: Timestamp?
    var id = UUID()
    var firstName: String
    var lastName: String

    var numbers: [PhoneNumber]

    var systemContact: CNContact? // --> We keep a reference to later make it easier for editing the same contact.

    struct PhoneNumber { // --> We also have a PhoneNumber struct as they can have labels and we want to display them
        var label: String
        var number: String
    }

    init(firstName: String, lastName: String, numbers: [PhoneNumber], systemContact: CNContact) {
        self.firstName = firstName
        self.lastName = lastName
        self.numbers = numbers
        self.systemContact = systemContact
    }

    init(firstName: String, lastName: String, numbers: [PhoneNumber]) {
        self.firstName = firstName
        self.lastName = lastName
        self.numbers = numbers
    }

    static func fromCNContact(contact: CNContact) -> Contact {
        let numbers = contact.phoneNumbers.map({
            (value: CNLabeledValue<CNPhoneNumber>) -> Contact.PhoneNumber in

            let localized = CNLabeledValue<NSString>.localizedString(forLabel: value.label ?? "")

            return Contact.PhoneNumber.init(label: localized, number: value.value.stringValue)

        })

        return self.init(firstName: contact.givenName, lastName: contact.familyName, numbers: numbers, systemContact: contact)
    }

    func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}

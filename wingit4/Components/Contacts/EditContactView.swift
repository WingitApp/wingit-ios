//
//  EditContactView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Foundation
import SwiftUI
import ContactsUI

struct EditContactView: UIViewControllerRepresentable {
    class Coordinator: NSObject, CNContactViewControllerDelegate, UINavigationControllerDelegate {
        func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) { // --> this gets called when the user taps done or cancels the editing/creation of a contact
            if let c = contact {
                self.parent.contact = c
            }

            viewController.dismiss(animated: true)
        }

        var parent: EditContactView

        init(_ parent: EditContactView) {
            self.parent = parent
        }
    }

    @Binding var contact: CNContact

    init(contact: Binding<CNContact>) {
        self._contact = contact
    }

    typealias UIViewControllerType = CNContactViewController

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<EditContactView>) -> EditContactView.UIViewControllerType {
        if self.contact.identifier.count != 0 { // --> for editing: here, we check if the contact is actually empty (so, a new one) or already exists
            do {
                let descriptor = CNContactViewController.descriptorForRequiredKeys()

                let store = CNContactStore()

                let editContact = try store.unifiedContact(withIdentifier: self.contact.identifier, keysToFetch: [descriptor])

                let vc = CNContactViewController(for: editContact) // --> if there's a contact we can edit, we disply the system's view for editing contacts
                vc.delegate = context.coordinator

                return vc
            } catch {
                print("could not find contact, this happens when we are trying to create a new contact that doesn't exist yet")
                print(error)
            }
        }

        let vc = CNContactViewController(forNewContact: CNContact()) // --> otherwise, we can assume that we want to create a new contact, so we display a fresh view
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: EditContactView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditContactView>) {

    }
}

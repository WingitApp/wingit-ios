//
//  ContactDetailView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import SwiftUI

struct ContactDetailView: View {
    @ObservedObject var viewModel: ContactDetailViewModel

    init(contact: Contact) {
        self.viewModel = ContactDetailViewModel(contact: contact)
    }

    var body: some View {
        Form() { // --> Form gives us a neat style to replicate the style we already know from the standard contacts app
            HStack() {
                Text(viewModel.contact.firstName)
                Text(viewModel.contact.lastName)
            }
            .padding(.vertical)
            .font(.system(.title))


            Section() {
                ForEach(viewModel.contact.numbers, id: \.number) { number in // --> here, we display all the numbers we got
                    Button(action: { /* do something */ }) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(number.label)
                                .font(.system(.subheadline))
                                .foregroundColor(.secondary)
                            Text(number.number)
                        }
                    }
                }
            }
        }
        .navigationBarItems(trailing:
            Button(action: { self.viewModel.showEditContactView = true }) {
                Text("Edit")
            }
            .disabled(self.viewModel.contact.systemContact == nil) // --> we don't want to let the user edit a non-system contact (like the aforementioned cloud-contacts, for example)
            .sheet(isPresented: self.$viewModel.showEditContactView) {
                NavigationView() {
                    EditContactView(contact: .constant(self.viewModel.contact.systemContact!)) // --> here, we pass the system contact we set in the beginning!
                }
                .switchStyle(if: UIDevice.current.userInterfaceIdiom == .phone)
                .onDisappear() {
                    self.viewModel.updateContact() // --> notify our view model to update the displayed contact
                }
            }
        )
    }
}

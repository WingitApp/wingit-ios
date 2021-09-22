//
//  ContactsList.swift
//  wingit4
//
//  Created by Daniel Yee on 9/17/21.
//

import Foundation
import MessageUI
import SwiftUI

struct ContactsListView: View {
    @State private var isShowingMessages = false
    @State private var numberToText: String = ""
    @State private var message = TEXT_SHARE_WINGIT
    @ObservedObject var viewModel = ContactsListViewModel()

    var body: some View {
         VStack {
            SearchBar(text: $viewModel.searchText, placeholder: "Search contacts")

            List {
                // Filtered list of names
                ForEach(viewModel.contacts.filter { viewModel.contactFilter(contact: $0)}, id:\.id) { contact in // --> We display all filtered contacts
                    Button(action: {
                        sendMessage(numberToMessage: contact.numbers[0].number)
                    }, label: {
                        ContactItem(contact: contact)
                    })
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
    
    func sendMessage(numberToMessage: String) {
        let sms: String = "sms:\(numberToMessage)&body=\(message)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    func handleCompletion(_ result: MessageComposeResult) {
        switch result {
        case .cancelled:
            self.isShowingMessages = false
        case .sent:
            self.isShowingMessages = false
        case .failed:
            self.isShowingMessages = false
        @unknown default:
            self.isShowingMessages = false
        }
    }
}

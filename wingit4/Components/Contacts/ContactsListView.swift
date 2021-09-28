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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingMessages = false
    @State private var numberToText: String = ""
    @State private var message = TEXT_SHARE_WINGIT
    @ObservedObject var viewModel = ContactsListViewModel()

    var body: some View {
         VStack {
          HStack(alignment: .center) {
            Text(
              Image(systemName: "chevron.left")
            )
              .fontWeight(.semibold)
              .font(.system(size: 25))
              .foregroundColor(.wingitBlue)
              .onTapGesture {
                Haptic.impact(type: "soft")
                self.presentationMode.wrappedValue.dismiss()
              }
            .padding(.top, 15)
            
            Spacer()
            Capsule()
             .fill(Color.gray)
             .frame(width: 60, height: 4)
              .offset(x: -10)
              .padding(.leading, 10)
            Spacer()
          }
          .padding(.leading, 10)
          .padding(.trailing, 10)
         
            SearchBar(text: $viewModel.searchText, placeholder: "Search for contacts to invite")

            ScrollView(){
                // Filtered list of names
              VStack(alignment: .leading) {
                ForEach(viewModel.contacts.filter { viewModel.contactFilter(contact: $0)}, id:\.id) { contact in // --> We display all filtered contacts
                    Button(action: {
                        sendMessage(numberToMessage: contact.numbers[0].number)
                        logToAmplitude(event: .referContact, properties: [.name: contact.fullName(), .medium: "SMS"])
                    }, label: {
                        ContactItem(contact: contact, phoneNumber: contact.numbers[0].number)
                    })
                    
                    .buttonStyle(PlainButtonStyle())
                    Divider()
                  }
       
              }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
              .onEnded({ value in
                  if value.translation.width > 0 {
                      // right
                    Haptic.impact(type: "soft")
                    self.presentationMode.wrappedValue.dismiss()
                  }
              }))
//            .modifier(ResignKeyboardOnDragGesture())
        }
         .onAppear {
            viewModel.fetch()
         }
         .navigationBarTitle("")
         .navigationBarHidden(true)
        

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

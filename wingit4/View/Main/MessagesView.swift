//
//  MessagesView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import URLImage

struct MessagesView: View {
    
    @ObservedObject var messageViewModel = MessageViewModel()

    
    var body: some View {
               List {
                if !messageViewModel.inboxMessages.isEmpty {
                    ForEach(messageViewModel.inboxMessages, id: \.id) { inboxMessage in
                        NavigationLink(destination: ChatView(recipientId: inboxMessage.userId, recipientAvatarUrl: inboxMessage.avatarUrl, recipientUsername: inboxMessage.username)) {
                            HStack {
                                       URLImage(URL(string: inboxMessage.avatarUrl)!,
                                                                                          content: {
                                                                                              $0.image
                                                                                                  .resizable()
                                                                                                  .aspectRatio(contentMode: .fill)
                                                                                                  .clipShape(Circle())
                                                                                          })
                                      .frame(width: 50, height: 50)
                                  VStack(alignment: .leading, spacing: 5) {
                                    Text(inboxMessage.username).font(.headline).bold()
                                    Text(inboxMessage.lastMessage).font(.subheadline).lineLimit(2)
                                  }
                                  Spacer()
                                 VStack(spacing: 5) {
                                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: inboxMessage.date), currentDate: Date(), numericDates: true)).bold().padding(.leading, 15)

//                                 Text("2").padding(8).background(Color.blue).foregroundColor(Color.white).clipShape(Circle())
                                 }
                                  
                              }.padding(10)
                        }
                        
                     }
                }
              
               }.navigationBarTitle(Text("Messages"), displayMode: .automatic).onDisappear {
                   if self.messageViewModel.listener != nil {
                       self.messageViewModel.listener.remove()
                   }
               }
    }
}


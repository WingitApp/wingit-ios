//
//  HeaderCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct HeaderCell: View {
  
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post
  
    var body: some View {
        VStack {
            HStack {
              NavigationLink(destination: self.askCardViewModel.destination) {
                HStack {
                  URLImageView(urlString: post.avatar)
                    .clipShape(Circle())
                    .frame(width: 35, height: 35)
                    .overlay(
                      RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                   
                  VStack(alignment: .leading){
                    Text(post.username)
                      .fontWeight(.semibold)
                      .modifier(UserNameStyle())
                    TimeAgoStamp(date: post.date)
                  }
                }
              }
              .disabled(self.askCardViewModel.isNavLinkDisabled)
              .buttonStyle(FlatLinkStyle())
              .buttonStyle(PlainButtonStyle())

              
              Spacer()
//              AskDoneToggle() // rename later
              AskMenu()
            }.padding(.trailing, 15).padding(.leading, 15)
        }
        .padding(.top, 15)
    }
}

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
                URLImage(URL(string: post.avatar)!,
                   content: {
                      $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                   })
                  .frame(width: 35, height: 35)
                  .overlay(
                    RoundedRectangle(cornerRadius: 100)
                      .stroke(Color.gray, lineWidth: 1)
                  )

              }.disabled(self.askCardViewModel.isNavLinkDisabled)
              VStack(alignment: .leading){
                Text(post.username)
                  .fontWeight(.semibold)
                  .modifier(UserNameStyle())
                TimeAgoStamp(date: post.date)
              }
              Spacer()
//              AskDoneToggle() // rename later
              AskMenu()
            }.padding(.trailing, 15).padding(.leading, 15)
        }
        .padding(.top, 15)
    }
}

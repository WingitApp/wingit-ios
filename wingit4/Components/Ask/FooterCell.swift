//
//  FooterCell.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//
import SwiftUI
import URLImage

struct FooterCell: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel
  
  @StateObject var shareButtonViewModel = ShareButtonViewModel()
    
    var body: some View {
      VStack(alignment: .leading) {
          HStack {
               NavigationLink(destination:  UserProfileView(userId: post.ownerId, user: nil)) {
                      HStack {
                        URLImageView(urlString: post.avatar)
                          .clipShape(Circle())
                          .frame(width: 30, height: 30)
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
                      .onTapGesture {
                        Haptic.impact(type: "soft")
                      }
                    }
                    .disabled(self.askCardViewModel.isNavLinkDisabled)
                    .buttonStyle(FlatLinkStyle())
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 5)
            Spacer()
            CommentButton(
              
//              showLabel: true
            )
            ReferButton(
              post: $post
//              showLabel: true
            )
          }
          
        
      }
      .padding(.top, 5)
      .padding(.leading, 15)
      .padding(.trailing, 15)
      .padding(.bottom, 15)
      .frame(maxWidth: UIScreen.main.bounds.width - 30)
    }
}

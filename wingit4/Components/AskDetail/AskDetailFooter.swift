//
//  AskDetailFooter.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailFooter: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel
  @StateObject var shareButtonViewModel = ShareButtonViewModel()


    var body: some View {
      VStack {
        Divider()
        HStack {
//          URLImageView(urlString: post.avatar)
//            .clipShape(Circle())
//            .frame(width: 30, height: 30)
//            .overlay(
//              RoundedRectangle(cornerRadius: 100)
//                .stroke(Color.gray, lineWidth: 1)
//            )
//          VStack(alignment: .leading){
//            Text(post.username)
//              .font(.headline)
//              .fontWeight(.bold)
//            TimeAgoStamp(date: post.date)
//              .font(.caption2)
//          }
          Spacer()
          CommentButton(
            isTapDisabled: true
          )
          ReferButton(
            post: $post
          )
        }
        .padding(
          EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 15)
        )
        Divider()
      }
  
    }
}
